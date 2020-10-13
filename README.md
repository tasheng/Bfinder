To setup Bfinder
=====

Ref: https://twiki.cern.ch/twiki/bin/view/CMS/HiReco2021

```
cmsrel CMSSW_10_3_3_patch1
cd CMSSW_10_3_3_patch1/src
cmsenv
git cms-merge-topic -u CmsHI:forest_CMSSW_10_3_3_patch1_miniAOD
cd ../../
cmsrel CMSSW_11_2_0_pre7
cd CMSSW_11_2_0_pre7/src
cmsenv
cp -r ../../CMSSW_10_3_3_patch1/src/HeavyIonsAnalysis .
scram b -j4
```

To add D/Bfinder to forest:
=====

```
cd $CMSSW_BASE/src
cmsenv
git clone -b Dfinder_11XX https://github.com/boundino/Bfinder.git --depth 1
source Bfinder/test/DnBfinder_to_Forest_112X_miniAOD.sh
scram b -j4
mkdir -p dfinder && cp HeavyIonsAnalysis/JetAnalysis/test/forest_miniAOD_103X_DATA_onlyDfinder.py dfinder/forest_miniAOD_103X_DATA_onlyDfinder.py
cd dfinder/
```
* Comment out 
```
# import subprocess, os
# version = subprocess.check_output(
#     ['git', '-C', os.path.expandvars('$CMSSW_BASE/src'), 'describe', '--tags'])
# if version == '':
#     version = 'no git info'
# process.HiForestInfo.HiForestVersion = cms.string(version)
```
in `forest_miniAOD_103X_DATA_onlyDfinder.py`.

To run:
=====

```
cmsRun forest_miniAOD_103X_DATA_onlyDfinder.py
```
