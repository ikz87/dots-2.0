const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#101012", /* black   */
  [1] = "#CFBFC0", /* red     */
  [2] = "#64AFA9", /* green   */
  [3] = "#CFB5AD", /* yellow  */
  [4] = "#E6D5CB", /* blue    */
  [5] = "#AD9E98", /* magenta */
  [6] = "#6DC8BF", /* cyan    */
  [7] = "#e9e2dd", /* white   */

  /* 8 bright colors */
  [8]  = "#27272c",  /* black   */
  [9]  = "#ffdbdf",  /* red     */
  [10] = "#70f5ea", /* green   */
  [11] = "#ffdec8", /* yellow  */
  [12] = "#fff4d5", /* blue    */
  [13] = "#f5c4b0", /* magenta */
  [14] = "#79ffff", /* cyan    */
  [15] = "#fffdf8", /* white   */

  /* special colors */
  [256] = "#101012", /* background */
  [257] = "#fffdf8", /* foreground */
  [258] = "#fffdf8",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
