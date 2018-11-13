Simple example of a hash of hashes hoh to split a table

* other methods;
https://tinyurl.com/y6uzqbm2
https://github.com/rogerjdeangelis/utl_thirteen_algorithms_to_split_a_table_based_on_groups_of_data

SAS Forum
https://tinyurl.com/ycadwusu
https://github.com/rogerjdeangelis/utl-simple-example-of-a-hash-of-hashes-hoh-to-split_a-table

https://tinyurl.com/yd3sfge2
https://communities.sas.com/t5/New-SAS-User/Using-an-Array-to-output-multiple-datasets-by-year-of-record/m-p/512591

novinosrin
https://communities.sas.com/t5/user/viewprofilepage/user-id/138205



INPUT
=====

WORK.HAVE total obs=18

   UNIQUE_
     ID       START     END     MONTHDATE    CURRENTYEAR

   000001     OCT12    FEB13    01OCT2012       2012
   000001     OCT12    FEB13    01NOV2012       2012
   000001     OCT12    FEB13    01DEC2012       2012
   000001     OCT12    FEB13    01JAN2013       2013
   000001     OCT12    FEB13    01FEB2013       2013
   000016     JUN11    MAY14    01JUN2011       2011
   000016     JUN11    MAY14    01JUL2011       2011
   000016     JUN11    MAY14    01AUG2011       2011
   000016     JUN11    MAY14    01SEP2011       2011
   000016     JUN11    MAY14    01OCT2011       2011
   000016     JUN11    MAY14    01NOV2011       2011
   000016     JUN11    MAY14    01DEC2011       2011
   000016     JUN11    MAY14    01JAN2012       2012
   000016     JUN11    MAY14    01FEB2012       2012
   000016     JUN11    MAY14    01MAR2012       2012
   000016     JUN11    MAY14    01MAR2014       2014
   000016     JUN11    MAY14    01APR2014       2014
   000016     JUN11    MAY14    01MAY2014       2014



RULES (after a sort by currentyear)


40 obs WORK.HAVSRT total obs=18
                                                       | RULES (create 4 tables)
 UNIQUE_                                               | ------------------------
   ID       START     END     MONTHDATE    CURRENTYEAR |
                                                       |
 000016     JUN11    MAY14    01JUN2011       2011     |
 000016     JUN11    MAY14    01JUL2011       2011     |
 000016     JUN11    MAY14    01AUG2011       2011     |
 000016     JUN11    MAY14    01SEP2011       2011     |
 000016     JUN11    MAY14    01OCT2011       2011     |
 000016     JUN11    MAY14    01NOV2011       2011     |
 000016     JUN11    MAY14    01DEC2011       2011     |  CURRENTYEAR_2011.sas7bdat
                                                       |
 000001     OCT12    FEB13    01OCT2012       2012     |
 000001     OCT12    FEB13    01NOV2012       2012     |
 000001     OCT12    FEB13    01DEC2012       2012     |
 000016     JUN11    MAY14    01JAN2012       2012     |
 000016     JUN11    MAY14    01FEB2012       2012     |
 000016     JUN11    MAY14    01MAR2012       2012     |  CURRENTYEAR_2012.sas7bdat
                                                       |
 000001     OCT12    FEB13    01JAN2013       2013     |
 000001     OCT12    FEB13    01FEB2013       2013     |
                                                       |  CURRENTYEAR_2013.sas7bdat
 000016     JUN11    MAY14    01MAR2014       2014     |
 000016     JUN11    MAY14    01APR2014       2014     |
 000016     JUN11    MAY14    01MAY2014       2014     |  CURRENTYEAR_2014.sas7bdat


EXAMPLE OUTPUT
--------------

NOTE: The data set WORK.CURRENTYEAR_2012 has 6 observations and 5 variables.
NOTE: The data set WORK.CURRENTYEAR_2014 has 3 observations and 5 variables.
NOTE: The data set WORK.CURRENTYEAR_2011 has 7 observations and 5 variables.
NOTE: The data set WORK.CURRENTYEAR_2013 has 2 observations and 5 variables.

PROCESS
=======

* first we load the four currentyear levels in a hash;
* then we use these levels to output one dataset;
* fro each year level;


data _null_;
if _n_=1 then do;
   dcl hash Hoh () ;
      hoh.definekey  ("CURRENTYEAR") ;
      hoh.definedata ("CURRENTYEAR", "h") ;
      hoh.definedone () ;
    dcl hash H ;
end;

set have end=dne;

* load the detal data;
if hoh.find() ne 0 then do;
   h= _new_ hash(multidata:'y');
   h.definekey  ("_iorc_") ;
   h.definedata ('UNIQUE_ID','START','END','MONTHDATE','CURRENTYEAR') ;
   h.definedone () ;
   hoh.add();
end;

h.add();

dcl hiter hi('hoh');

if dne;

do while(hi.next()=0); * iterate though the years and output detail data;
   h.output(dataset:catx('_','currentyear',CURRENTYEAR));
end;
run;

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

data have;
input (UNIQUE_ID START END MONTHDATE CURRENTYEAR) (: $10.);
cards4;
000001 OCT12 FEB13 01OCT2012 2012
000001 OCT12 FEB13 01NOV2012 2012
000001 OCT12 FEB13 01DEC2012 2012
000001 OCT12 FEB13 01JAN2013 2013
000001 OCT12 FEB13 01FEB2013 2013
000016 JUN11 MAY14 01JUN2011 2011
000016 JUN11 MAY14 01JUL2011 2011
000016 JUN11 MAY14 01AUG2011 2011
000016 JUN11 MAY14 01SEP2011 2011
000016 JUN11 MAY14 01OCT2011 2011
000016 JUN11 MAY14 01NOV2011 2011
000016 JUN11 MAY14 01DEC2011 2011
000016 JUN11 MAY14 01JAN2012 2012
000016 JUN11 MAY14 01FEB2012 2012
000016 JUN11 MAY14 01MAR2012 2012
000016 JUN11 MAY14 01MAR2014 2014
000016 JUN11 MAY14 01APR2014 2014
000016 JUN11 MAY14 01MAY2014 2014
;;;;
run;quit;






