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

typedef           char     Word8;
typedef  unsigned char     UWord8;
typedef           short    Word16;
typedef  unsigned short    UWord16;
typedef           int      Word32;
typedef  unsigned int      UWord32;

#define SERIAL_SIZE     10      /* bytes per frame                           */
#define L_FRAME         80      /* LPC update frame size                     */

void codecProG729_EncoderInit(void);
void codecProG729_Encode(Word16 *pSpeech, UWord8 *pBitstream);

void codecProG729_DecoderInit(void);
void codecProG729_decode(UWord8 *pBitstream, Word16 *pSynthSpeech, Word16 iBadFrame);
