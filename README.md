To setup Bfinder
=====

2023 pp and PbPb data/MC from miniAOD
Ref: https://twiki.cern.ch/twiki/bin/viewauth/CMS/HiForestSetup

```
cmsrel CMSSW_13_2_4
cd CMSSW_13_2_4/src
cmsenv
git cms-merge-topic CmsHI:forest_CMSSW_13_2_X
scram b -j4
```

To add D/Bfinder to forest:
=====

```
cd $CMSSW_BASE/src
cmsenv
git clone -b 13XX_miniAOD https://github.com/milanchestojanovic/Bfinder.git --depth 1
source Bfinder/test/DnBfinder_to_Forest_132X_miniAOD.sh
scram b -j4
mkdir -p dfinder && cp HeavyIonsAnalysis/Configuration/test/forest_miniAOD_run3_MC_wDfinder.py dfinder/
cd dfinder/
```

To run:
=====

```
cmsRun forest_miniAOD_run2_MC_wDfinder.py
```
