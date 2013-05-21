/* dxfReader for OpenSceneGraph  Copyright (C) 2005 by GraphArchitecture ( grapharchitecture.com )
 * Programmed by Paul de Repentigny <pdr@grapharchitecture.com>
 *
 * OpenSceneGraph is (C) 2004 Robert Osfield
 *
 * This library is provided as-is, without support of any kind.
 *
 * Read DXF docs or OSG docs for any related questions.
 *
 * You may contact the author if you have suggestions/corrections/enhancements.
 */

#include "aci.h"

double aci::table[256*3] =
{
  /*   dummy   */  0,0,0,
  /*   1   */  1,0,0,
  /*   2   */  1,1,0,
  /*   3   */  0,1,0,
  /*   4   */  0,1,1,
  /*   5   */  0,0,1,
  /*   6   */  1,0,1,
  /*   7   */  1,1,1,
  /*   8 user defined  */  1,1,1,
  /*   9 user defined  */  1,1,1,
  /*   10   */  1,0,0,
  /*   11   */  1,0.5,0.5,
  /*   12   */  0.65,0,0,
  /*   13   */  0.65,0.325,0.325,
  /*   14   */  0.5,0,0,
  /*   15   */  0.5,0.25,0.25,
  /*   16   */  0.3,0,0,
  /*   17   */  0.3,0.15,0.15,
  /*   18   */  0.15,0,0,
  /*   19   */  0.15,0.075,0.075,
  /*   20   */  1,0.25,0,
  /*   21   */  1,0.625,0.5,
  /*   22   */  0.65,0.1625,0,
  /*   23   */  0.65,0.4063,0.325,
  /*   24   */  0.5,0.125,0,
  /*   25   */  0.5,0.3125,0.25,
  /*   26   */  0.3,0.075,0,
  /*   27   */  0.3,0.1875,0.15,
  /*   28   */  0.15,0.0375,0,
  /*   29   */  0.15,0.0938,0.075,
  /*   30   */  1,0.5,0,
  /*   31   */  1,0.75,0.5,
  /*   32   */  0.65,0.325,0,
  /*   33   */  0.65,0.4875,0.325,
  /*   34   */  0.5,0.25,0,
  /*   35   */  0.5,0.375,0.25,
  /*   36   */  0.3,0.15,0,
  /*   37   */  0.3,0.225,0.15,
  /*   38   */  0.15,0.075,0,
  /*   39   */  0.15,0.1125,0.075,
  /*   40   */  1,0.75,0,
  /*   41   */  1,0.875,0.5,
  /*   42   */  0.65,0.4875,0,
  /*   43   */  0.65,0.5688,0.325,
  /*   44   */  0.5,0.375,0,
  /*   45   */  0.5,0.4375,0.25,
  /*   46   */  0.3,0.225,0,
  /*   47   */  0.3,0.2625,0.15,
  /*   48   */  0.15,0.1125,0,
  /*   49   */  0.15,0.1313,0.075,
  /*   50   */  1,1,0,
  /*   51   */  1,1,0.5,
  /*   52   */  0.65,0.65,0,
  /*   53   */  0.65,0.65,0.325,
  /*   54   */  0.5,0.5,0,
  /*   55   */  0.5,0.5,0.25,
  /*   56   */  0.3,0.3,0,
  /*   57   */  0.3,0.3,0.15,
  /*   58   */  0.15,0.15,0,
  /*   59   */  0.15,0.15,0.075,
  /*   60   */  0.75,1,0,
  /*   61   */  0.875,1,0.5,
  /*   62   */  0.4875,0.65,0,
  /*   63   */  0.5688,0.65,0.325,
  /*   64   */  0.375,0.5,0,
  /*   65   */  0.4375,0.5,0.25,
  /*   66   */  0.225,0.3,0,
  /*   67   */  0.2625,0.3,0.15,
  /*   68   */  0.1125,0.15,0,
  /*   69   */  0.1313,0.15,0.075,
  /*   70   */  0.5,1,0,
  /*   71   */  0.75,1,0.5,
  /*   72   */  0.325,0.65,0,
  /*   73   */  0.4875,0.65,0.325,
  /*   74   */  0.25,0.5,0,
  /*   75   */  0.375,0.5,0.25,
  /*   76   */  0.15,0.3,0,
  /*   77   */  0.225,0.3,0.15,
  /*   78   */  0.075,0.15,0,
  /*   79   */  0.1125,0.15,0.075,
  /*   80   */  0.25,1,0,
  /*   81   */  0.625,1,0.5,
  /*   82   */  0.1625,0.65,0,
  /*   83   */  0.4063,0.65,0.325,
  /*   84   */  0.125,0.5,0,
  /*   85   */  0.3125,0.5,0.25,
  /*   86   */  0.075,0.3,0,
  /*   87   */  0.1875,0.3,0.15,
  /*   88   */  0.0375,0.15,0,
  /*   89   */  0.0938,0.15,0.075,
  /*   90   */  0,1,0,
  /*   91   */  0.5,1,0.5,
  /*   92   */  0,0.65,0,
  /*   93   */  0.325,0.65,0.325,
  /*   94   */  0,0.5,0,
  /*   95   */  0.25,0.5,0.25,
  /*   96   */  0,0.3,0,
  /*   97   */  0.15,0.3,0.15,
  /*   98   */  0,0.15,0,
  /*   99   */  0.075,0.15,0.075,
  /*   100   */  0,1,0.25,
  /*   101   */  0.5,1,0.625,
  /*   102   */  0,0.65,0.1625,
  /*   103   */  0.325,0.65,0.4063,
  /*   104   */  0,0.5,0.125,
  /*   105   */  0.25,0.5,0.3125,
  /*   106   */  0,0.3,0.075,
  /*   107   */  0.15,0.3,0.1875,
  /*   108   */  0,0.15,0.0375,
  /*   109   */  0.075,0.15,0.0938,
  /*   110   */  0,1,0.5,
  /*   111   */  0.5,1,0.75,
  /*   112   */  0,0.65,0.325,
  /*   113   */  0.325,0.65,0.4875,
  /*   114   */  0,0.5,0.25,
  /*   115   */  0.25,0.5,0.375,
  /*   116   */  0,0.3,0.15,
  /*   117   */  0.15,0.3,0.225,
  /*   118   */  0,0.15,0.075,
  /*   119   */  0.075,0.15,0.1125,
  /*   120   */  0,1,0.75,
  /*   121   */  0.5,1,0.875,
  /*   122   */  0,0.65,0.4875,
  /*   123   */  0.325,0.65,0.5688,
  /*   124   */  0,0.5,0.375,
  /*   125   */  0.25,0.5,0.4375,
  /*   126   */  0,0.3,0.225,
  /*   127   */  0.15,0.3,0.2625,
  /*   128   */  0,0.15,0.1125,
  /*   129   */  0.075,0.15,0.1313,
  /*   130   */  0,1,1,
  /*   131   */  0.5,1,1,
  /*   132   */  0,0.65,0.65,
  /*   133   */  0.325,0.65,0.65,
  /*   134   */  0,0.5,0.5,
  /*   135   */  0.25,0.5,0.5,
  /*   136   */  0,0.3,0.3,
  /*   137   */  0.15,0.3,0.3,
  /*   138   */  0,0.15,0.15,
  /*   139   */  0.075,0.15,0.15,
  /*   140   */  0,0.75,1,
  /*   141   */  0.5,0.875,1,
  /*   142   */  0,0.4875,0.65,
  /*   143   */  0.325,0.5688,0.65,
  /*   144   */  0,0.375,0.5,
  /*   145   */  0.25,0.4375,0.5,
  /*   146   */  0,0.225,0.3,
  /*   147   */  0.15,0.2625,0.3,
  /*   148   */  0,0.1125,0.15,
  /*   149   */  0.075,0.1313,0.15,
  /*   150   */  0,0.5,1,
  /*   151   */  0.5,0.75,1,
  /*   152   */  0,0.325,0.65,
  /*   153   */  0.325,0.4875,0.65,
  /*   154   */  0,0.25,0.5,
  /*   155   */  0.25,0.375,0.5,
  /*   156   */  0,0.15,0.3,
  /*   157   */  0.15,0.225,0.3,
  /*   158   */  0,0.075,0.15,
  /*   159   */  0.075,0.1125,0.15,
  /*   160   */  0,0.25,1,
  /*   161   */  0.5,0.625,1,
  /*   162   */  0,0.1625,0.65,
  /*   163   */  0.325,0.4063,0.65,
  /*   164   */  0,0.125,0.5,
  /*   165   */  0.25,0.3125,0.5,
  /*   166   */  0,0.075,0.3,
  /*   167   */  0.15,0.1875,0.3,
  /*   168   */  0,0.0375,0.15,
  /*   169   */  0.075,0.0938,0.15,
  /*   170   */  0,0,1,
  /*   171   */  0.5,0.5,1,
  /*   172   */  0,0,0.65,
  /*   173   */  0.325,0.325,0.65,
  /*   174   */  0,0,0.5,
  /*   175   */  0.25,0.25,0.5,
  /*   176   */  0,0,0.3,
  /*   177   */  0.15,0.15,0.3,
  /*   178   */  0,0,0.15,
  /*   179   */  0.075,0.075,0.15,
  /*   180   */  0.25,0,1,
  /*   181   */  0.625,0.5,1,
  /*   182   */  0.1625,0,0.65,
  /*   183   */  0.4063,0.325,0.65,
  /*   184   */  0.125,0,0.5,
  /*   185   */  0.3125,0.25,0.5,
  /*   186   */  0.075,0,0.3,
  /*   187   */  0.1875,0.15,0.3,
  /*   188   */  0.0375,0,0.15,
  /*   189   */  0.0938,0.075,0.15,
  /*   190   */  0.5,0,1,
  /*   191   */  0.75,0.5,1,
  /*   192   */  0.325,0,0.65,
  /*   193   */  0.4875,0.325,0.65,
  /*   194   */  0.25,0,0.5,
  /*   195   */  0.375,0.25,0.5,
  /*   196   */  0.15,0,0.3,
  /*   197   */  0.225,0.15,0.3,
  /*   198   */  0.075,0,0.15,
  /*   199   */  0.1125,0.075,0.15,
  /*   200   */  0.75,0,1,
  /*   201   */  0.875,0.5,1,
  /*   202   */  0.4875,0,0.65,
  /*   203   */  0.5688,0.325,0.65,
  /*   204   */  0.375,0,0.5,
  /*   205   */  0.4375,0.25,0.5,
  /*   206   */  0.225,0,0.3,
  /*   207   */  0.2625,0.15,0.3,
  /*   208   */  0.1125,0,0.15,
  /*   209   */  0.1313,0.075,0.15,
  /*   210   */  1,0,1,
  /*   211   */  1,0.5,1,
  /*   212   */  0.65,0,0.65,
  /*   213   */  0.65,0.325,0.65,
  /*   214   */  0.5,0,0.5,
  /*   215   */  0.5,0.25,0.5,
  /*   216   */  0.3,0,0.3,
  /*   217   */  0.3,0.15,0.3,
  /*   218   */  0.15,0,0.15,
  /*   219   */  0.15,0.075,0.15,
  /*   220   */  1,0,0.75,
  /*   221   */  1,0.5,0.875,
  /*   222   */  0.65,0,0.4875,
  /*   223   */  0.65,0.325,0.5688,
  /*   224   */  0.5,0,0.375,
  /*   225   */  0.5,0.25,0.4375,
  /*   226   */  0.3,0,0.225,
  /*   227   */  0.3,0.15,0.2625,
  /*   228   */  0.15,0,0.1125,
  /*   229   */  0.15,0.075,0.1313,
  /*   230   */  1,0,0.5,
  /*   231   */  1,0.5,0.75,
  /*   232   */  0.65,0,0.325,
  /*   233   */  0.65,0.325,0.4875,
  /*   234   */  0.5,0,0.25,
  /*   235   */  0.5,0.25,0.375,
  /*   236   */  0.3,0,0.15,
  /*   237   */  0.3,0.15,0.225,
  /*   238   */  0.15,0,0.075,
  /*   239   */  0.15,0.075,0.1125,
  /*   240   */  1,0,0.25,
  /*   241   */  1,0.5,0.625,
  /*   242   */  0.65,0,0.1625,
  /*   243   */  0.65,0.325,0.4063,
  /*   244   */  0.5,0,0.125,
  /*   245   */  0.5,0.25,0.3125,
  /*   246   */  0.3,0,0.075,
  /*   247   */  0.3,0.15,0.1875,
  /*   248   */  0.15,0,0.0375,
  /*   249   */  0.15,0.075,0.0938,
  /*   250   */  0.33,0.33,0.33,
  /*   251   */  0.464,0.464,0.464,
  /*   252   */  0.598,0.598,0.598,
  /*   253   */  0.732,0.732,0.732,
  /*   254   */  0.866,0.866,0.866,
  /*   255   */  1,1,1
};
