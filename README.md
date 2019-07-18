To setup Bfinder
=====

Ref: https://twiki.cern.ch/twiki/bin/viewauth/CMS/HiForestSetup#Setup_for_9_4_10_For_2017_pp_ReR

```
cmsrel CMSSW_9_4_10
cd CMSSW_9_4_10/src
cmsenv
git cms-merge-topic -u CmsHI:forest_CMSSW_9_4_10
git remote add cmshi git@github.com:CmsHI/cmssw.git
cd HeavyIonsAnalysis/JetAnalysis/python/jets
./makeJetSequences.sh
cd ../../../..
scram build -j4
```

To add D/Bfinder to forest:
=====

```
cd $CMSSW_BASE/src
cmsenv
git clone -branch Dfinder_9XX https://github.com/boundino/Bfinder.git
source Bfinder/test/DnBfinder_to_Forest_94X.sh
scram b -j4
# Bfinder MC:
mkdir -p bfinder && cp HeavyIonsAnalysis/JetAnalysis/test/runForestAOD_pponAA_MC_94X_onlyBfinder.py bfinder/runForestAOD_pponAA_MC_94X_onlyBfinder.py
# Bfinder data:
mkdir -p bfinder && cp HeavyIonsAnalysis/JetAnalysis/test/runForestAOD_pponAA_DATA_94X_onlyBfinder.py bfinder/runForestAOD_pponAA_DATA_94X_onlyBfinder.py
cd bfinder/
```

To run:
=====

* MC:
```
cmsRun runForestAOD_pponAA_MC_94X_onlyBfinder.py
```
* data:
```
cmsRun runForestAOD_pponAA_DATA_94X_onlyBfinder.py
```
