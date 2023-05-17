To setup Bfinder
=====

2022 or 2018 PbPb data/MC from miniAOD
Ref: https://twiki.cern.ch/twiki/bin/viewauth/CMS/HiForestSetup#Setup_for_12_5_X_2022_or_2018_Pb

```
cmsrel CMSSW_12_5_0
cd CMSSW_12_5_0/src
cmsenv
git cms-merge-topic CmsHI:forest_CMSSW_12_5_0
scram b -j4
```

To add D/Bfinder to forest:
=====

```
cd $CMSSW_BASE/src
cmsenv
git clone -b Dfinder_12XX_miniAOD https://github.com/boundino/Bfinder.git --depth 1
source Bfinder/test/DnBfinder_to_Forest_125X_miniAOD.sh
scram b -j4
mkdir -p dfinder && cp HeavyIonsAnalysis/Configuration/test/forest_miniAOD_run3_MC_wDfinder.py dfinder/
cd dfinder/
```

To run:
=====

```
cmsRun forest_miniAOD_run2_DATA_wDfinder.py
```
