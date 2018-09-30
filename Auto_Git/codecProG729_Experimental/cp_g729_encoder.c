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

int main( int argc, char *argv[])
{
   FILE *f_speech;                     /* Speech data        */
   FILE *f_serial;                     /* Serial bit stream  */

   unsigned char serial [SERIAL_SIZE];   /* Output bit stream buffer      */
   Word16 speech[L_FRAME];         /* Buffer to read 16 bits speech */

   UWord32 nb_frame = 0;

   printf("\n");
   printf("************       CodecPro Incorporated        **************\n");
   printf("\n");
   printf("--------- G.729 Floating point C simulation encoder ----------\n");
   printf("\n");
   printf("----------------   (Non-Commercial use only>   ---------------\n");
   printf("\n");


   /*-----------------------------------------------------------------------*
    * Open speech file and result file (output serial bit stream)           *
    *-----------------------------------------------------------------------*/

   if ( argc != 3 )
     {
        printf("Usage : %s  speech_file  bitstream_file \n", argv[0]);
        printf("\n");
        printf("Format for speech_file:\n");
        printf("  Speech is read form a binary file of 16 bits data.\n");
        printf("\n");
        printf("Format for bitstream_file:\n");
        printf("  10 bytes frame as per RFC3551 \n");
        printf("\n");
        return(1);
     }

   if ( (f_speech = fopen(argv[1], "rb")) == NULL) {
      printf("Error opening file  %s !!\n", argv[1]);
      return(1);
   }

   if ( (f_serial = fopen(argv[2], "wb")) == NULL) {
      printf("Error opening file  %s !!\n", argv[2]);
      return(1);
   }

   printf(" Input speech file     :  %s\n", argv[1]);
   printf(" Output bitstream file :  %s\n", argv[2]);

  /*-------------------------------------------------*
   * Initialization of the coder.                    *
   *-------------------------------------------------*/
   codecProG729_EncoderInit();

   while( fread((void *)speech, sizeof(UWord16), L_FRAME, f_speech) == L_FRAME){
      
      printf("Encode frame %d\r", ++nb_frame);
      
      codecProG729_Encode(speech, serial);
      fwrite( serial, sizeof(unsigned char), SERIAL_SIZE,  f_serial);
   }

   printf("\n");
   return(0);

}
