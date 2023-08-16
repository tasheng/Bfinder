#!/bin/bash

PATHTOTEST=$CMSSW_BASE/src/HeavyIonsAnalysis/Configuration/test/
FORESTS=(forest_miniAOD_run3_DATA forest_miniAOD_run3_MC)
RUNONMC=(False True)
INFILES=(
    "/store/hidata/HIRun2018A/HIHeavyFlavor/MINIAOD/PbPb18_MiniAODv1-v1/240000/fdf05837-6240-4773-8cd7-d889d991ba17.root"
    "/store/group/phys_heavyions/dileptons/junseok/RECO_MINIAOD_MC_DsPU_forPPRef_CMSSW_13_2_0_pre1_10Jun2023_v1/Ds_TuneCP5_5p36TeV_ppref-pythia8_new/RECO_MINIAOD_MC_DsPU_forPPRef_CMSSW_13_2_0_pre1_10Jun2023_v1/230720_170204/0000/step3_RECO_MINIAODSIM_39.root"
)
MINIMUMTREES=0

cc=0
for FOREST in ${FORESTS[@]}
do
    ##
    cp ${PATHTOTEST}/${FOREST}.py ${PATHTOTEST}/${FOREST}_wDfinder.py

    echo '
#################### D/B finder ################# 
AddCaloMuon = False 
runOnMC = '${RUNONMC[cc]}' ## !!
HIFormat = False 
UseGenPlusSim = False 
# VtxLabel = "unpackedTracksAndVertices"
VtxLabel = "offlineSlimmedPrimaryVerticesRecovery"
TrkLabel = "packedPFCandidates"
GenLabel = "prunedGenParticles"
TrkChi2Label = "packedPFCandidateTrackChi2"
useL1Stage2 = True
HLTProName = "HLT"
from Bfinder.finderMaker.finderMaker_75X_cff import finderMaker_75X 
finderMaker_75X(process, AddCaloMuon, runOnMC, HIFormat, UseGenPlusSim, VtxLabel, TrkLabel, TrkChi2Label, GenLabel, useL1Stage2, HLTProName)
process.Dfinder.MVAMapLabel = cms.InputTag(TrkLabel, "MVAValues")
process.Dfinder.makeDntuple = cms.bool(True)
process.Dfinder.tkPtCut = cms.double(5.0) # before fit
process.Dfinder.tkEtaCut = cms.double(2.4) # before fit
process.Dfinder.dPtCut = cms.vdouble(10.0, 10.0, 1.0, 1.0, 1.0, 1.0, 2.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 2.0) # before fit
process.Dfinder.VtxChiProbCut = cms.vdouble(0.05, 0.05, 0.0, 0.0, 0.0, 0.0, 0.05, 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.05, 0.05)
process.Dfinder.dCutSeparating_PtVal = cms.vdouble(5., 5., 5., 5., 5., 5., 5., 5., 5., 5., 5., 5., 5., 5., 5., 5.)
process.Dfinder.tktkRes_svpvDistanceCut_lowptD = cms.vdouble(0., 0., 0., 0., 0., 0., 0., 0., 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 0., 0.)
process.Dfinder.tktkRes_svpvDistanceCut_highptD = cms.vdouble(0., 0., 0., 0., 0., 0., 0., 0., 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 0., 0.)
process.Dfinder.svpvDistanceCut_lowptD = cms.vdouble(2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 0., 0., 0., 0., 0., 0., 2.5, 2.5)
process.Dfinder.svpvDistanceCut_highptD = cms.vdouble(2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 0., 0., 0., 0., 0., 0., 2.5, 2.5)
process.Dfinder.Dchannel = cms.vint32(1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
process.Dfinder.dropUnusedTracks = cms.bool(True)
process.Dfinder.detailMode = cms.bool(False)

process.dfinder = cms.Path(process.DfinderSequence)

' >> ${PATHTOTEST}/${FOREST}_wDfinder.py

    ##
    cp ${PATHTOTEST}/${FOREST}.py ${PATHTOTEST}/${FOREST}_wBfinder.py

    echo '
#################### D/B finder #################
AddCaloMuon = False
runOnMC = '${RUNONMC[cc]}' ## !!
HIFormat = False
UseGenPlusSim = False
# VtxLabel = "unpackedTracksAndVertices"
VtxLabel = "offlineSlimmedPrimaryVerticesRecovery"
TrkLabel = "packedPFCandidates"
GenLabel = "prunedGenParticles"
useL1Stage2 = True
HLTProName = "HLT"
from Bfinder.finderMaker.finderMaker_75X_cff import finderMaker_75X
finderMaker_75X(process, AddCaloMuon, runOnMC, HIFormat, UseGenPlusSim, VtxLabel, TrkLabel, GenLabel, useL1Stage2, HLTProName)

process.Bfinder.MVAMapLabel = cms.InputTag(TrkLabel,"MVAValues")
process.Bfinder.makeBntuple = cms.bool(True)
process.Bfinder.tkPtCut = cms.double(0.8) # before fit
process.Bfinder.tkEtaCut = cms.double(2.4) # before fit
process.Bfinder.jpsiPtCut = cms.double(0.0) # before fit
process.Bfinder.bPtCut = cms.vdouble(3.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0) # before fit
process.Bfinder.Bchannel = cms.vint32(1, 0, 0, 1, 1, 1, 1)
process.Bfinder.VtxChiProbCut = cms.vdouble(0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.10)
process.Bfinder.svpvDistanceCut = cms.vdouble(2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 0.0)
process.Bfinder.doTkPreCut = cms.bool(True)
process.Bfinder.doMuPreCut = cms.bool(True)
process.Bfinder.MuonTriggerMatchingPath = cms.vstring(
    "HLT_HIL3Mu0NHitQ10_L2Mu0_MAXdR3p5_M1to5_v1")
process.Bfinder.MuonTriggerMatchingFilter = cms.vstring(
    "hltL3f0L3Mu0L2Mu0DR3p5FilteredNHitQ10M1to5")
process.p = cms.Path(process.BfinderSequence)

' >> ${PATHTOTEST}/${FOREST}_wBfinder.py

    configfiles="${PATHTOTEST}/${FOREST}_wDfinder.py ${PATHTOTEST}/${FOREST}_wBfinder.py"
    #
    [[ $MINIMUMTREES -eq 1 ]] && {
        cp ${PATHTOTEST}/${FOREST}_wDfinder.py ${PATHTOTEST}/${FOREST}_onlyDfinder.py
        cp ${PATHTOTEST}/${FOREST}_wBfinder.py ${PATHTOTEST}/${FOREST}_onlyBfinder.py

        for ifile in ${PATHTOTEST}/${FOREST}_onlyBfinder.py ${PATHTOTEST}/${FOREST}_onlyDfinder.py
        do
            sed -i "/D\/B finder/i \\
process.ana_step = cms.Path( \\
    process.HiForest \\
    + \\
    process.particleFlowAnalyser \\
    ) \\
" $ifile
        done
        configfiles=$configfiles" ${PATHTOTEST}/${FOREST}_onlyDfinder.py ${PATHTOTEST}/${FOREST}_onlyBfinder.py"
    }

    #
    for ifile in $configfiles
    do
        echo '
###############################
import FWCore.ParameterSet.VarParsing as VarParsing
ivars = VarParsing.VarParsing('"'"'analysis'"'"')

ivars.maxEvents = -1
ivars.outputFile='"'"'HiForestMINIAOD.root'"'"'
ivars.inputFiles='"'${INFILES[cc]}'"'
ivars.parseArguments() # get and parse the command line arguments

process.source = cms.Source("PoolSource",
    fileNames = cms.untracked.vstring(ivars.inputFiles),
    # eventsToProcess = cms.untracked.VEventRange('"'"'1:236:29748033-1:236:29748033'"'"')
)

process.maxEvents = cms.untracked.PSet(
    input = cms.untracked.int32(ivars.maxEvents)
)

process.TFileService = cms.Service("TFileService",
    fileName = cms.string(ivars.outputFile))
' >> $ifile
    done
    ##
    cc=$((cc+1))
done
