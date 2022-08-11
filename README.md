To setup Bfinder
=====

Ref: https://twiki.cern.ch/twiki/bin/view/CMS/L1HITaskForce2022#Instructions_to_run_the_L1Em_AN1

```
cmsrel CMSSW_12_4_0
cd CMSSW_12_4_0/src
cmsenv
git cms-merge-topic CmsHI:forest_CMSSW_12_4_0
scram b -j4
```

To add D/Bfinder to forest:
=====

```
cd $CMSSW_BASE/src
cmsenv
git clone -b Dfinder_12XX_miniAOD https://github.com/boundino/Bfinder.git --depth 1
source Bfinder/test/DnBfinder_to_Forest_124X_miniAOD.sh
scram b -j4
mkdir -p dfinder && cp HeavyIonsAnalysis/Configuration/test/forest_miniAOD_run3_MC_wDfinder.py dfinder/
cd dfinder/
```

To run:
=====

```
cmsRun forest_miniAOD_run3_MC_wDfinder.py
```
