/*--------------------------------------------------------------------------------*
 *                                                                                *
 * CodecPro Incorporated                                                          *
 * 2162 Av Laurier E                                                              *
 * Montreal (Quebec)                                                              *
 * Canada, H2H 1C2                                                                *
 *                                                                                *
 * www.codecpro.com                                                               *
 *                                                                                *
 * This material is subject to continuous developments and improvements. All      *
 * warranties implied or expressed, including but not limited to, implied         *
 * warranties of merchantability, fitness for purpose, condition of title,        *
 * noninfringement, are excluded. In no event shall CodecPro Incorporated and its *
 * suppliers be liable for any special, indirect or consequential damages or any  *
 * damages whatsoever arising out of or in connection with the use of this        *
 * information. The foregoing disclaimer shall apply to the maximum extent        *
 * permitted by applicable law, even if any remedy fails its essential purpose.   *
 *                                                                                *
 *                     NON-COMMERCIAL use only.                                   *
 *                                                                                *
 * For a commercial version please contact CodecPro at sales@codecpro.com         *
 *                                                                                *
 *--------------------------------------------------------------------------------*/

#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>

#include "cp_g729.h"

/*-----------------------------------------------------------------*
 *            Main decoder routine                                 *
 *-----------------------------------------------------------------*/

int main( int argc, char *argv[])
{
   UWord8 serial[SERIAL_SIZE];             // G.729 encoded serial stream
   Word16 synth[L_FRAME];                 // decoder output, 16-bit PCM samples

   Word16 bfi;

   UWord32 nb_frame = 0;

   FILE   *f_syn, *f_serial;

   printf("\n");
   printf("**************       CodecPro Incorporated        ************\n");
   printf("\n");
   printf("----------------- G729 Floating point decoder ----------------\n");
   printf("\n");
   printf("----------------   (Non-Commercial use only>   ---------------\n");
   printf("\n");


   if ( argc != 3)
     {
        printf("Usage :%s bitstream_file  outputspeech_file\n",argv[0]);
        printf("\n");
        printf("Format for bitstream_file:\n");
        printf("  10 bytes frame as per RFC3551 \n");
        printf("\n");
        printf("Format for outputspeech_file:\n");
        printf("  Synthesis is written to a binary file of 16 bits raw pcm data.\n");
        return(1);
     }

   /* Open file for synthesis and packed serial stream */

   if( (f_serial = fopen(argv[1],"rb") ) == NULL )
     {
        printf("Error opening file  %s !!\n", argv[1]);
        return(1);
     }

   if( (f_syn = fopen(argv[2], "wb") ) == NULL )
     {
        printf("Error opening file  %s !!\n", argv[2]);
        return(1);
     }

   printf("Input bitstream file  :   %s\n",argv[1]);
   printf("Synthesis speech file :   %s\n",argv[2]);

/*-----------------------------------------------------------------*
 *           Initialization of decoder                             *
 *-----------------------------------------------------------------*/

  codecProG729_DecoderInit();

/*-----------------------------------------------------------------*
 *            Loop for each "L_FRAME" speech data                  *
 *-----------------------------------------------------------------*/

   while( fread(serial, sizeof(UWord8), SERIAL_SIZE, f_serial) == SERIAL_SIZE)
   {

      printf("Decode frame %d\r", ++nb_frame);
		
      /*--------------------------------------------------------------*
       * Bad frame                                                    *
       *                                                              *
       * bfi = 0 to indicate that we have a correct frame             *
       * bfi = 1 to indicate that we lost the current frame           *
       *--------------------------------------------------------------*/

      bfi = 0;

      codecProG729_decode(serial, synth, bfi);
      fwrite(synth, sizeof(Word16), L_FRAME, f_syn);
   }

   printf("\n");
   return(0);
}
