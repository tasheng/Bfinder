To setup Bfinder
=====

Ref: https://twiki.cern.ch/twiki/bin/view/CMS/HiReco2021

```
cmsrel CMSSW_11_2_0_pre9
cd CMSSW_11_2_0_pre9/src
cmsenv
git cms-merge-topic -u CmsHI:forest_miniAOD_CMSSW_11_2_0
scram b -j4
```

To add D/Bfinder to forest:
=====

```
cd $CMSSW_BASE/src
cmsenv
git clone -b Dfinder_11XX_miniAOD https://github.com/boundino/Bfinder.git --depth 1
source Bfinder/test/DnBfinder_to_Forest_112X_miniAOD.sh
scram b -j4
mkdir -p dfinder && cp HeavyIonsAnalysis/JetAnalysis/test/forest_miniAOD_112X_MC_wDfinder.py dfinder/
mkdir -p dfinder && cp HeavyIonsAnalysis/JetAnalysis/test/forest_miniAOD_112X_DATA_wDfinder.py dfinder/
cd dfinder/
```

To run:
=====

```
cmsRun forest_miniAOD_112X_DATA_wDfinder.py
# or
cmsRun forest_miniAOD_112X_MC_wDfinder.py
```
