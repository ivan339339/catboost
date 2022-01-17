PY23_LIBRARY()

LICENSE(BSD-3-Clause)



VERSION(0.18.1)

IF (NOT SCIPY0)
    PEERDIR(contrib/python/scipy/py2)
ELSE()

PEERDIR(
    contrib/libs/cblas
    contrib/libs/clapack
    contrib/libs/libf2c
    contrib/libs/qhull
    contrib/python/numpy
)

CFLAGS(
    -Dc_sqrt=SuperLU_c_sqrt
    -Dc_exp=SuperLU_c_exp
    # Some of the -fcommon problems can be fixed by scipy update,
    # see https://st.yandex-team.ru/CONTRIB-1250
    # Additional notes regarging -fcommon in numpy can be found at
    # https://nda.ya.ru/t/9EdYTMTv4cGJF2
    -fcommon
)

IF (OS_WINDOWS)
    CFLAGS(
        -D_USE_MATH_DEFINES
        -DNO_TIMER=1
    )
ENDIF()

ADDINCL(
    contrib/libs/qhull

    contrib/python/scipy/scipy/cluster
    contrib/python/scipy/scipy/interpolate
    contrib/python/scipy/scipy/io/matlab
    contrib/python/scipy/scipy/linalg
    contrib/python/scipy/scipy/spatial
    contrib/python/scipy/scipy/spatial/ckdtree/src
    contrib/python/scipy/scipy/special
    contrib/python/scipy/scipy/special/c_misc
    FOR cython contrib/python/scipy
)

NO_LINT()

NO_COMPILER_WARNINGS()

NO_CHECK_IMPORTS(
    scipy.misc.pilutil
)

SRCS(
    # scipy/_build_utils/src/apple_sgemv_fix.c
    scipy/_build_utils/src/wrap_accelerate_c.c
    scipy/_build_utils/src/wrap_accelerate_f.f
    # scipy/_build_utils/src/wrap_dummy_accelerate.f
    # scipy/_build_utils/src/wrap_dummy_g77_abi.f
    scipy/_build_utils/src/wrap_g77_abi_c.c
    scipy/_build_utils/src/wrap_g77_abi_f.f

    scipy/fftpack/convolvemodule.c
    scipy/fftpack/_fftpackmodule.c
    scipy/fftpack/src/dst.c
    scipy/fftpack/src/dct.c
    scipy/fftpack/src/convolve.c
    scipy/fftpack/src/zrfft.c
    scipy/fftpack/src/zfftnd.c
    scipy/fftpack/src/drfft.c
    scipy/fftpack/src/zfft.c
    scipy/fftpack/src/dfftpack/dcosti.f
    scipy/fftpack/src/dfftpack/dsint1.f
    scipy/fftpack/src/dfftpack/zffti.f
    scipy/fftpack/src/dfftpack/dffti1.f
    scipy/fftpack/src/dfftpack/zfftf1.f
    scipy/fftpack/src/dfftpack/dsinqf.f
    scipy/fftpack/src/dfftpack/dfftf1.f
    scipy/fftpack/src/dfftpack/zfftb1.f
    scipy/fftpack/src/dfftpack/zffti1.f
    scipy/fftpack/src/dfftpack/dcosqf.f
    scipy/fftpack/src/dfftpack/dfftf.f
    scipy/fftpack/src/dfftpack/dsinqb.f
    scipy/fftpack/src/dfftpack/dfftb1.f
    scipy/fftpack/src/dfftpack/dsinqi.f
    scipy/fftpack/src/dfftpack/dfftb.f
    scipy/fftpack/src/dfftpack/zfftf.f
    scipy/fftpack/src/dfftpack/dsint.f
    scipy/fftpack/src/dfftpack/dcosqb.f
    scipy/fftpack/src/dfftpack/dcost.f
    scipy/fftpack/src/dfftpack/zfftb.f
    scipy/fftpack/src/dfftpack/dffti.f
    scipy/fftpack/src/dfftpack/dsinti.f
    scipy/fftpack/src/dfftpack/dcosqi.f
    scipy/fftpack/src/fftpack/cosqb.f
    scipy/fftpack/src/fftpack/rfftb1.f
    scipy/fftpack/src/fftpack/sinti.f
    scipy/fftpack/src/fftpack/cfftb1.f
    scipy/fftpack/src/fftpack/rfftf1.f
    scipy/fftpack/src/fftpack/rffti1.f
    scipy/fftpack/src/fftpack/sinqf.f
    scipy/fftpack/src/fftpack/cosqi.f
    scipy/fftpack/src/fftpack/cost.f
    scipy/fftpack/src/fftpack/sint1.f
    scipy/fftpack/src/fftpack/cfftb.f
    scipy/fftpack/src/fftpack/rfftf.f
    scipy/fftpack/src/fftpack/sinqi.f
    scipy/fftpack/src/fftpack/cfftf.f
    scipy/fftpack/src/fftpack/cffti1.f
    scipy/fftpack/src/fftpack/costi.f
    scipy/fftpack/src/fftpack/rfftb.f
    scipy/fftpack/src/fftpack/cosqf.f
    scipy/fftpack/src/fftpack/cfftf1.f
    scipy/fftpack/src/fftpack/sint.f
    scipy/fftpack/src/fftpack/cffti.f
    scipy/fftpack/src/fftpack/sinqb.f
    scipy/fftpack/src/fftpack/rffti.f

    scipy/integrate/_dopmodule.c
    scipy/integrate/_odepackmodule.c
    scipy/integrate/_quadpackmodule.c
    scipy/integrate/lsodamodule.c
    scipy/integrate/vodemodule.c

    scipy/integrate/dop/dop853.f
    scipy/integrate/dop/dopri5.f

    # scipy/integrate/mach/d1mach.f in scipy/special/mach/
    # scipy/integrate/mach/xerror.f in scipy/special/mach/

    scipy/integrate/odepack/blkdta000.f
    scipy/integrate/odepack/bnorm.f
    scipy/integrate/odepack/cfode.f
    scipy/integrate/odepack/ewset.f
    scipy/integrate/odepack/fnorm.f
    scipy/integrate/odepack/intdy.f
    scipy/integrate/odepack/lsoda.f
    scipy/integrate/odepack/prja.f
    scipy/integrate/odepack/solsy.f
    scipy/integrate/odepack/srcma.f
    scipy/integrate/odepack/stoda.f
    scipy/integrate/odepack/vmnorm.f
    scipy/integrate/odepack/vode.f
    scipy/integrate/odepack/xerrwv.f
    # scipy/integrate/odepack/xsetf.f in vode.f
    # scipy/integrate/odepack/xsetun.f in vode.f
    scipy/integrate/odepack/zvode.f

    scipy/integrate/quadpack/dqag.f
    scipy/integrate/quadpack/dqagi.f
    scipy/integrate/quadpack/dqagie.f
    scipy/integrate/quadpack/dqagp.f
    scipy/integrate/quadpack/dqagpe.f
    scipy/integrate/quadpack/dqags.f
    scipy/integrate/quadpack/dqagse.f
    scipy/integrate/quadpack/dqawc.f
    scipy/integrate/quadpack/dqawce.f
    scipy/integrate/quadpack/dqawf.f
    scipy/integrate/quadpack/dqawfe.f
    scipy/integrate/quadpack/dqawo.f
    scipy/integrate/quadpack/dqawoe.f
    scipy/integrate/quadpack/dqaws.f
    scipy/integrate/quadpack/dqawse.f
    scipy/integrate/quadpack/dqc25c.f
    scipy/integrate/quadpack/dqc25f.f
    scipy/integrate/quadpack/dqc25s.f
    scipy/integrate/quadpack/dqcheb.f
    scipy/integrate/quadpack/dqelg.f
    scipy/integrate/quadpack/dqk15.f
    scipy/integrate/quadpack/dqk15i.f
    scipy/integrate/quadpack/dqk15w.f
    scipy/integrate/quadpack/dqk21.f
    scipy/integrate/quadpack/dqk31.f
    scipy/integrate/quadpack/dqk41.f
    scipy/integrate/quadpack/dqk51.f
    scipy/integrate/quadpack/dqk61.f
    scipy/integrate/quadpack/dqmomo.f
    scipy/integrate/quadpack/dqng.f
    scipy/integrate/quadpack/dqpsrt.f
    scipy/integrate/quadpack/dqwgtc.f
    scipy/integrate/quadpack/dqwgtf.f
    scipy/integrate/quadpack/dqwgts.f

    scipy/interpolate/fitpack/bispeu.f
    scipy/interpolate/fitpack/bispev.f
    scipy/interpolate/fitpack/clocur.f
    scipy/interpolate/fitpack/cocosp.f
    scipy/interpolate/fitpack/concon.f
    scipy/interpolate/fitpack/concur.f
    scipy/interpolate/fitpack/cualde.f
    scipy/interpolate/fitpack/curev.f
    scipy/interpolate/fitpack/curfit.f
    scipy/interpolate/fitpack/dblint.f
    scipy/interpolate/fitpack/evapol.f
    scipy/interpolate/fitpack/fourco.f
    scipy/interpolate/fitpack/fpader.f
    scipy/interpolate/fitpack/fpadno.f
    scipy/interpolate/fitpack/fpadpo.f
    scipy/interpolate/fitpack/fpback.f
    scipy/interpolate/fitpack/fpbacp.f
    scipy/interpolate/fitpack/fpbfout.f
    scipy/interpolate/fitpack/fpbisp.f
    scipy/interpolate/fitpack/fpbspl.f
    scipy/interpolate/fitpack/fpchec.f
    scipy/interpolate/fitpack/fpched.f
    scipy/interpolate/fitpack/fpchep.f
    scipy/interpolate/fitpack/fpclos.f
    scipy/interpolate/fitpack/fpcoco.f
    scipy/interpolate/fitpack/fpcons.f
    scipy/interpolate/fitpack/fpcosp.f
    scipy/interpolate/fitpack/fpcsin.f
    scipy/interpolate/fitpack/fpcurf.f
    scipy/interpolate/fitpack/fpcuro.f
    scipy/interpolate/fitpack/fpcyt1.f
    scipy/interpolate/fitpack/fpcyt2.f
    scipy/interpolate/fitpack/fpdeno.f
    scipy/interpolate/fitpack/fpdisc.f
    scipy/interpolate/fitpack/fpfrno.f
    scipy/interpolate/fitpack/fpgivs.f
    scipy/interpolate/fitpack/fpgrdi.f
    scipy/interpolate/fitpack/fpgrpa.f
    scipy/interpolate/fitpack/fpgrre.f
    scipy/interpolate/fitpack/fpgrsp.f
    scipy/interpolate/fitpack/fpinst.f
    scipy/interpolate/fitpack/fpintb.f
    scipy/interpolate/fitpack/fpknot.f
    scipy/interpolate/fitpack/fpopdi.f
    scipy/interpolate/fitpack/fpopsp.f
    scipy/interpolate/fitpack/fporde.f
    scipy/interpolate/fitpack/fppara.f
    scipy/interpolate/fitpack/fppasu.f
    scipy/interpolate/fitpack/fpperi.f
    scipy/interpolate/fitpack/fppocu.f
    scipy/interpolate/fitpack/fppogr.f
    scipy/interpolate/fitpack/fppola.f
    scipy/interpolate/fitpack/fprank.f
    scipy/interpolate/fitpack/fprati.f
    scipy/interpolate/fitpack/fpregr.f
    scipy/interpolate/fitpack/fprota.f
    scipy/interpolate/fitpack/fprppo.f
    scipy/interpolate/fitpack/fprpsp.f
    scipy/interpolate/fitpack/fpseno.f
    scipy/interpolate/fitpack/fpspgr.f
    scipy/interpolate/fitpack/fpsphe.f
    scipy/interpolate/fitpack/fpsuev.f
    scipy/interpolate/fitpack/fpsurf.f
    scipy/interpolate/fitpack/fpsysy.f
    scipy/interpolate/fitpack/fptrnp.f
    scipy/interpolate/fitpack/fptrpe.f
    scipy/interpolate/fitpack/insert.f
    scipy/interpolate/fitpack/parcur.f
    scipy/interpolate/fitpack/parder.f
    scipy/interpolate/fitpack/pardeu.f
    scipy/interpolate/fitpack/parsur.f
    scipy/interpolate/fitpack/percur.f
    scipy/interpolate/fitpack/pogrid.f
    scipy/interpolate/fitpack/polar.f
    scipy/interpolate/fitpack/profil.f
    scipy/interpolate/fitpack/regrid.f
    scipy/interpolate/fitpack/spalde.f
    scipy/interpolate/fitpack/spgrid.f
    scipy/interpolate/fitpack/sphere.f
    scipy/interpolate/fitpack/splder.f
    scipy/interpolate/fitpack/splev.f
    scipy/interpolate/fitpack/splint.f
    scipy/interpolate/fitpack/sproot.f
    scipy/interpolate/fitpack/surev.f
    scipy/interpolate/fitpack/surfit.f

    scipy/interpolate/src/_fitpackmodule.c
    scipy/interpolate/src/_interpolate.cpp
    scipy/interpolate/src/dfitpackmodule.c
    scipy/interpolate/src/dfitpack-f2pywrappers.f

    scipy/linalg/_fblasmodule.c
    scipy/linalg/_flapackmodule.c
    scipy/linalg/_calc_lworkmodule.c
    scipy/linalg/_flinalgmodule.c
    scipy/linalg/_interpolativemodule.c
    scipy/linalg/_blas_subroutine_wrappers.f
    scipy/linalg/_lapack_subroutine_wrappers.f
    scipy/linalg/_fblas-f2pywrappers.f
    scipy/linalg/_flapack-f2pywrappers.f

    scipy/linalg/src/calc_lwork.f
    scipy/linalg/src/det.f
    scipy/linalg/src/lu.f

    # scipy/linalg/src/id_dist/src/dfft_subr_*.f in fftpack
    scipy/linalg/src/id_dist/src/idd_frm_subr_0.f
    scipy/linalg/src/id_dist/src/idd_frm_subr_1.f
    scipy/linalg/src/id_dist/src/idd_frm_subr_2.f
    scipy/linalg/src/id_dist/src/idd_frm_subr_3.f
    scipy/linalg/src/id_dist/src/idd_frm_subr_4.f
    scipy/linalg/src/id_dist/src/idd_frm_subr_5.f
    scipy/linalg/src/id_dist/src/idd_frm_subr_6.f
    scipy/linalg/src/id_dist/src/idd_frm_subr_7.f
    scipy/linalg/src/id_dist/src/idd_frm_subr_8.f
    scipy/linalg/src/id_dist/src/idd_house_subr_0.f
    scipy/linalg/src/id_dist/src/idd_house_subr_1.f
    scipy/linalg/src/id_dist/src/idd_house_subr_2.f
    scipy/linalg/src/id_dist/src/idd_id2svd_subr_0.f
    scipy/linalg/src/id_dist/src/idd_id2svd_subr_1.f
    scipy/linalg/src/id_dist/src/idd_id2svd_subr_2.f
    scipy/linalg/src/id_dist/src/idd_id2svd_subr_3.f
    scipy/linalg/src/id_dist/src/idd_id2svd_subr_4.f
    scipy/linalg/src/id_dist/src/idd_id2svd_subr_5.f
    scipy/linalg/src/id_dist/src/idd_id_subr_0.f
    scipy/linalg/src/id_dist/src/idd_id_subr_1.f
    scipy/linalg/src/id_dist/src/idd_id_subr_2.f
    scipy/linalg/src/id_dist/src/idd_id_subr_3.f
    scipy/linalg/src/id_dist/src/idd_id_subr_4.f
    scipy/linalg/src/id_dist/src/idd_id_subr_5.f
    scipy/linalg/src/id_dist/src/idd_id_subr_6.f
    scipy/linalg/src/id_dist/src/idd_id_subr_7.f
    scipy/linalg/src/id_dist/src/iddp_aid_subr_0.f
    scipy/linalg/src/id_dist/src/iddp_aid_subr_1.f
    scipy/linalg/src/id_dist/src/iddp_aid_subr_2.f
    scipy/linalg/src/id_dist/src/iddp_aid_subr_3.f
    scipy/linalg/src/id_dist/src/iddp_aid_subr_4.f
    scipy/linalg/src/id_dist/src/iddp_aid_subr_5.f
    scipy/linalg/src/id_dist/src/iddp_asvd_subr_0.f
    scipy/linalg/src/id_dist/src/iddp_asvd_subr_1.f
    scipy/linalg/src/id_dist/src/iddp_rid_subr_0.f
    scipy/linalg/src/id_dist/src/iddp_rid_subr_1.f
    scipy/linalg/src/id_dist/src/iddp_rid_subr_2.f
    scipy/linalg/src/id_dist/src/iddp_rid_subr_3.f
    scipy/linalg/src/id_dist/src/iddp_rid_subr_4.f
    scipy/linalg/src/id_dist/src/iddp_rsvd_subr_0.f
    scipy/linalg/src/id_dist/src/iddp_rsvd_subr_1.f
    scipy/linalg/src/id_dist/src/idd_qrpiv_subr_0.f
    scipy/linalg/src/id_dist/src/idd_qrpiv_subr_1.f
    scipy/linalg/src/id_dist/src/idd_qrpiv_subr_2.f
    scipy/linalg/src/id_dist/src/idd_qrpiv_subr_3.f
    scipy/linalg/src/id_dist/src/idd_qrpiv_subr_4.f
    scipy/linalg/src/id_dist/src/idd_qrpiv_subr_5.f
    scipy/linalg/src/id_dist/src/iddr_aid_subr_0.f
    scipy/linalg/src/id_dist/src/iddr_aid_subr_1.f
    scipy/linalg/src/id_dist/src/iddr_aid_subr_2.f
    scipy/linalg/src/id_dist/src/iddr_aid_subr_3.f
    scipy/linalg/src/id_dist/src/iddr_asvd_subr_0.f
    scipy/linalg/src/id_dist/src/iddr_asvd_subr_1.f
    scipy/linalg/src/id_dist/src/iddr_rid_subr_0.f
    scipy/linalg/src/id_dist/src/iddr_rid_subr_1.f
    scipy/linalg/src/id_dist/src/iddr_rsvd_subr_0.f
    scipy/linalg/src/id_dist/src/iddr_rsvd_subr_1.f
    scipy/linalg/src/id_dist/src/idd_sfft_subr_0.f
    scipy/linalg/src/id_dist/src/idd_sfft_subr_1.f
    scipy/linalg/src/id_dist/src/idd_sfft_subr_2.f
    scipy/linalg/src/id_dist/src/idd_sfft_subr_3.f
    scipy/linalg/src/id_dist/src/idd_sfft_subr_4.f
    scipy/linalg/src/id_dist/src/idd_sfft_subr_5.f
    scipy/linalg/src/id_dist/src/idd_sfft_subr_6.f
    scipy/linalg/src/id_dist/src/idd_snorm_subr_0.f
    scipy/linalg/src/id_dist/src/idd_snorm_subr_1.f
    scipy/linalg/src/id_dist/src/idd_snorm_subr_2.f
    scipy/linalg/src/id_dist/src/idd_snorm_subr_3.f
    scipy/linalg/src/id_dist/src/idd_svd_subr_0.f
    scipy/linalg/src/id_dist/src/idd_svd_subr_1.f
    scipy/linalg/src/id_dist/src/idd_svd_subr_2.f
    scipy/linalg/src/id_dist/src/idd_svd_subr_3.f
    scipy/linalg/src/id_dist/src/idd_svd_subr_4.f
    scipy/linalg/src/id_dist/src/id_rand_subr_0.f
    scipy/linalg/src/id_dist/src/id_rand_subr_1.f
    scipy/linalg/src/id_dist/src/id_rand_subr_2.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_0.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_10.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_11.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_12.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_13.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_14.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_15.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_16.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_17.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_1.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_2.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_3.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_4.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_5.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_6.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_7.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_8.f
    scipy/linalg/src/id_dist/src/id_rtrans_subr_9.f
    scipy/linalg/src/id_dist/src/idz_frm_subr_0.f
    scipy/linalg/src/id_dist/src/idz_frm_subr_1.f
    scipy/linalg/src/id_dist/src/idz_frm_subr_2.f
    scipy/linalg/src/id_dist/src/idz_frm_subr_3.f
    scipy/linalg/src/id_dist/src/idz_frm_subr_4.f
    scipy/linalg/src/id_dist/src/idz_frm_subr_5.f
    scipy/linalg/src/id_dist/src/idz_frm_subr_6.f
    scipy/linalg/src/id_dist/src/idz_house_subr_0.f
    scipy/linalg/src/id_dist/src/idz_house_subr_1.f
    scipy/linalg/src/id_dist/src/idz_house_subr_2.f
    scipy/linalg/src/id_dist/src/idz_id2svd_subr_0.f
    scipy/linalg/src/id_dist/src/idz_id2svd_subr_1.f
    scipy/linalg/src/id_dist/src/idz_id2svd_subr_2.f
    scipy/linalg/src/id_dist/src/idz_id2svd_subr_3.f
    scipy/linalg/src/id_dist/src/idz_id2svd_subr_4.f
    scipy/linalg/src/id_dist/src/idz_id2svd_subr_5.f
    scipy/linalg/src/id_dist/src/idz_id_subr_0.f
    scipy/linalg/src/id_dist/src/idz_id_subr_1.f
    scipy/linalg/src/id_dist/src/idz_id_subr_2.f
    scipy/linalg/src/id_dist/src/idz_id_subr_3.f
    scipy/linalg/src/id_dist/src/idz_id_subr_4.f
    scipy/linalg/src/id_dist/src/idz_id_subr_5.f
    scipy/linalg/src/id_dist/src/idz_id_subr_6.f
    scipy/linalg/src/id_dist/src/idz_id_subr_7.f
    scipy/linalg/src/id_dist/src/idzp_aid_subr_0.f
    scipy/linalg/src/id_dist/src/idzp_aid_subr_1.f
    scipy/linalg/src/id_dist/src/idzp_aid_subr_2.f
    scipy/linalg/src/id_dist/src/idzp_aid_subr_3.f
    scipy/linalg/src/id_dist/src/idzp_aid_subr_4.f
    scipy/linalg/src/id_dist/src/idzp_aid_subr_5.f
    scipy/linalg/src/id_dist/src/idzp_asvd_subr_0.f
    scipy/linalg/src/id_dist/src/idzp_asvd_subr_1.f
    scipy/linalg/src/id_dist/src/idzp_asvd_subr_2.f
    scipy/linalg/src/id_dist/src/idzp_rid_subr_0.f
    scipy/linalg/src/id_dist/src/idzp_rid_subr_1.f
    scipy/linalg/src/id_dist/src/idzp_rid_subr_2.f
    scipy/linalg/src/id_dist/src/idzp_rid_subr_3.f
    scipy/linalg/src/id_dist/src/idzp_rid_subr_4.f
    scipy/linalg/src/id_dist/src/idzp_rsvd_subr_0.f
    scipy/linalg/src/id_dist/src/idzp_rsvd_subr_1.f
    scipy/linalg/src/id_dist/src/idzp_rsvd_subr_2.f
    scipy/linalg/src/id_dist/src/idz_qrpiv_subr_0.f
    scipy/linalg/src/id_dist/src/idz_qrpiv_subr_1.f
    scipy/linalg/src/id_dist/src/idz_qrpiv_subr_2.f
    scipy/linalg/src/id_dist/src/idz_qrpiv_subr_3.f
    scipy/linalg/src/id_dist/src/idz_qrpiv_subr_4.f
    scipy/linalg/src/id_dist/src/idz_qrpiv_subr_5.f
    scipy/linalg/src/id_dist/src/idzr_aid_subr_0.f
    scipy/linalg/src/id_dist/src/idzr_aid_subr_1.f
    scipy/linalg/src/id_dist/src/idzr_aid_subr_2.f
    scipy/linalg/src/id_dist/src/idzr_aid_subr_3.f
    scipy/linalg/src/id_dist/src/idzr_asvd_subr_0.f
    scipy/linalg/src/id_dist/src/idzr_asvd_subr_1.f
    scipy/linalg/src/id_dist/src/idzr_rid_subr_0.f
    scipy/linalg/src/id_dist/src/idzr_rid_subr_1.f
    scipy/linalg/src/id_dist/src/idzr_rsvd_subr_0.f
    scipy/linalg/src/id_dist/src/idzr_rsvd_subr_1.f
    scipy/linalg/src/id_dist/src/idz_sfft_subr_0.f
    scipy/linalg/src/id_dist/src/idz_sfft_subr_1.f
    scipy/linalg/src/id_dist/src/idz_sfft_subr_2.f
    scipy/linalg/src/id_dist/src/idz_snorm_subr_0.f
    scipy/linalg/src/id_dist/src/idz_snorm_subr_1.f
    scipy/linalg/src/id_dist/src/idz_snorm_subr_2.f
    scipy/linalg/src/id_dist/src/idz_snorm_subr_3.f
    scipy/linalg/src/id_dist/src/idz_svd_subr_0.f
    scipy/linalg/src/id_dist/src/idz_svd_subr_1.f
    scipy/linalg/src/id_dist/src/idz_svd_subr_2.f
    scipy/linalg/src/id_dist/src/idz_svd_subr_3.f
    scipy/linalg/src/id_dist/src/idz_svd_subr_4.f
    scipy/linalg/src/id_dist/src/idz_svd_subr_5.f
    scipy/linalg/src/id_dist/src/prini_subr_0.f
    scipy/linalg/src/id_dist/src/prini_subr_1.f
    scipy/linalg/src/id_dist/src/prini_subr_2.f
    scipy/linalg/src/id_dist/src/prini_subr_3.f
    scipy/linalg/src/id_dist/src/prini_subr_4.f
    scipy/linalg/src/id_dist/src/prini_subr_5.f
    scipy/linalg/src/id_dist/src/prini_subr_6.f

    scipy/ndimage/src/_ctest.c
    scipy/ndimage/src/nd_image.c
    scipy/ndimage/src/ni_filters.c
    scipy/ndimage/src/ni_fourier.c
    scipy/ndimage/src/ni_interpolation.c
    scipy/ndimage/src/ni_measure.c
    scipy/ndimage/src/ni_morphology.c
    scipy/ndimage/src/ni_support.c

    scipy/odr/__odrpack.c
    scipy/odr/odrpack/d_odr.f
    scipy/odr/odrpack/d_mprec.f
    scipy/odr/odrpack/dlunoc.f
    scipy/odr/odrpack/d_lpk.f

    scipy/optimize/_minpackmodule.c
    scipy/optimize/zeros.c

    scipy/optimize/cobyla/cobyla2.f
    scipy/optimize/cobyla/_cobylamodule.c
    scipy/optimize/cobyla/trstlp.f

    scipy/optimize/lbfgsb/lbfgsb.f
    scipy/optimize/lbfgsb/linpack.f
    scipy/optimize/lbfgsb/timer.f
    scipy/optimize/lbfgsb/_lbfgsbmodule.c

    scipy/optimize/minpack/chkder.f
    scipy/optimize/minpack/dogleg.f
    scipy/optimize/minpack/dpmpar.f
    scipy/optimize/minpack/enorm.f
    scipy/optimize/minpack/fdjac1.f
    scipy/optimize/minpack/fdjac2.f
    scipy/optimize/minpack/hybrd1.f
    scipy/optimize/minpack/hybrd.f
    scipy/optimize/minpack/hybrj1.f
    scipy/optimize/minpack/hybrj.f
    scipy/optimize/minpack/lmder1.f
    scipy/optimize/minpack/lmder.f
    scipy/optimize/minpack/lmdif1.f
    scipy/optimize/minpack/lmdif.f
    scipy/optimize/minpack/lmpar.f
    scipy/optimize/minpack/lmstr1.f
    scipy/optimize/minpack/lmstr.f
    scipy/optimize/minpack/qform.f
    scipy/optimize/minpack/qrfac.f
    scipy/optimize/minpack/qrsolv.f
    scipy/optimize/minpack/r1mpyq.f
    scipy/optimize/minpack/r1updt.f
    scipy/optimize/minpack/rwupdt.f

    scipy/optimize/minpack2/minpack2module.c
    scipy/optimize/minpack2/dcsrch.f
    scipy/optimize/minpack2/dcstep.f

    scipy/optimize/nnls/nnls.f
    scipy/optimize/nnls/_nnlsmodule.c

    scipy/optimize/slsqp/_slsqpmodule.c
    scipy/optimize/slsqp/slsqp_optmz.f

    scipy/optimize/tnc/moduleTNC.c
    scipy/optimize/tnc/tnc.c

    scipy/optimize/Zeros/bisect.c
    scipy/optimize/Zeros/brenth.c
    scipy/optimize/Zeros/brentq.c
    scipy/optimize/Zeros/ridder.c

    scipy/signal/bspline_util.c
    scipy/signal/C_bspline_util.c
    scipy/signal/D_bspline_util.c
    scipy/signal/firfilter.c
    scipy/signal/medianfilter.c
    scipy/signal/S_bspline_util.c
    scipy/signal/sigtoolsmodule.c
    scipy/signal/splinemodule.c
    scipy/signal/Z_bspline_util.c
    scipy/signal/correlate_nd.c
    scipy/signal/lfilter.c

    scipy/sparse/linalg/dsolve/_superlumodule.c
    scipy/sparse/linalg/dsolve/_superluobject.c
    scipy/sparse/linalg/dsolve/_superlu_utils.c

    scipy/sparse/linalg/dsolve/SuperLU/SRC/ccolumn_bmod.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ccolumn_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ccopy_to_ucol.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cdiagonal.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cgscon.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cgsequ.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cgsisx.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cgsitrf.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cgsrfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cgssv.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cgssvx.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cgstrf.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cgstrs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/clacon2.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/clangs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/claqgs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cldperm.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cmemory.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cmyblas2.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/colamd.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cpanel_bmod.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cpanel_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cpivotgrowth.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cpivotL.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cpruneL.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/creadhb.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/creadrb.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/creadtriple.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/csnode_bmod.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/csnode_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/csp_blas2.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/csp_blas3.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/cutil.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dcolumn_bmod.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dcolumn_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dcomplex.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dcopy_to_ucol.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ddiagonal.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dgscon.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dgsequ.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dgsisx.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dgsitrf.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dgsrfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dgssv.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dgssvx.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dgstrf.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dgstrs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dlacon2.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dlangs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dlaqgs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dldperm.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dmach.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dmemory.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dmyblas2.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dpanel_bmod.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dpanel_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dpivotgrowth.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dpivotL.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dpruneL.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dreadhb.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dreadrb.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dreadtriple.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dsnode_bmod.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dsnode_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dsp_blas2.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dsp_blas3.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dutil.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/dzsum1.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/get_perm_c.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/heap_relax_snode.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/icmax1.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_ccolumn_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_ccopy_to_ucol.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_cdrop_row.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_cpanel_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_cpivotL.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_csnode_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_dcolumn_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_dcopy_to_ucol.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_ddrop_row.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_dpanel_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_dpivotL.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_dsnode_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_heap_relax_snode.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_relax_snode.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_scolumn_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_scopy_to_ucol.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_sdrop_row.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_spanel_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_spivotL.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_ssnode_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_zcolumn_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_zcopy_to_ucol.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_zdrop_row.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_zpanel_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_zpivotL.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ilu_zsnode_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/izmax1.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/mark_relax.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/memory.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/mmd.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/qselect.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/relax_snode.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/scolumn_bmod.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/scolumn_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/scomplex.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/scopy_to_ucol.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/scsum1.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sdiagonal.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sgscon.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sgsequ.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sgsisx.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sgsitrf.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sgsrfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sgssv.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sgssvx.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sgstrf.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sgstrs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/slacon2.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/slangs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/slaqgs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sldperm.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/smach.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/smemory.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/smyblas2.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/spanel_bmod.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/spanel_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sp_coletree.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sp_ienv.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/spivotgrowth.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/spivotL.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sp_preorder.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/spruneL.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sreadhb.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sreadrb.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sreadtriple.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ssnode_bmod.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ssnode_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ssp_blas2.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/ssp_blas3.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/superlu_timer.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/sutil.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/util.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zcolumn_bmod.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zcolumn_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zcopy_to_ucol.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zdiagonal.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zgscon.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zgsequ.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zgsisx.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zgsitrf.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zgsrfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zgssv.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zgssvx.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zgstrf.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zgstrs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zlacon2.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zlangs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zlaqgs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zldperm.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zmemory.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zmyblas2.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zpanel_bmod.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zpanel_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zpivotgrowth.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zpivotL.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zpruneL.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zreadhb.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zreadrb.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zreadtriple.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zsnode_bmod.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zsnode_dfs.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zsp_blas2.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zsp_blas3.c
    scipy/sparse/linalg/dsolve/SuperLU/SRC/zutil.c

    scipy/sparse/linalg/eigen/arpack/_arpackmodule.c
    scipy/sparse/linalg/eigen/arpack/_arpack-f2pywrappers.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/cnaupd.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dnaup2.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/sneigh.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dgetv0.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/snconv.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/znaup2.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/zneigh.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/ssaupd.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/sstatn.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/cnaup2.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/sstqrb.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/snaup2.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/cnaitr.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dneupd.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/znaupd.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/zstatn.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dseupd.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dsgets.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/sstats.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/cnapps.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/zngets.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dsaupd.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dngets.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/ssortc.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/cngets.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dsaitr.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dnapps.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/zneupd.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/zgetv0.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/snaitr.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dsortr.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/sseigt.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dseigt.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/znapps.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dstqrb.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dnaitr.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/zsortc.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/cneupd.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dsaup2.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/cneigh.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/cgetv0.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/ssaup2.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/ssgets.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dsapps.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/snaupd.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dsesrt.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dsortc.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/ssesrt.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dneigh.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dsconv.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/ssapps.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/sngets.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/snapps.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dstats.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/sseupd.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/ssconv.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dstatn.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/znaitr.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/sgetv0.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dnconv.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/cstatn.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/sneupd.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/csortc.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/ssaitr.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/ssortr.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/SRC/dnaupd.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/UTIL/zmout.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/UTIL/smout.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/UTIL/zvout.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/UTIL/svout.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/UTIL/icopy.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/UTIL/ivout.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/UTIL/dvout.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/UTIL/icnteq.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/UTIL/dmout.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/UTIL/iswap.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/UTIL/iset.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/UTIL/cvout.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/UTIL/cmout.f
    scipy/sparse/linalg/eigen/arpack/ARPACK/UTIL/second_NONE.f

    scipy/sparse/linalg/isolve/iterative/_iterativemodule.c
    scipy/sparse/linalg/isolve/iterative/BiCGREVCOM.f
    scipy/sparse/linalg/isolve/iterative/BiCGSTABREVCOM.f
    scipy/sparse/linalg/isolve/iterative/CGREVCOM.f
    scipy/sparse/linalg/isolve/iterative/CGSREVCOM.f
    scipy/sparse/linalg/isolve/iterative/getbreak.f
    scipy/sparse/linalg/isolve/iterative/GMRESREVCOM.f
    scipy/sparse/linalg/isolve/iterative/QMRREVCOM.f
    scipy/sparse/linalg/isolve/iterative/STOPTEST2.f

    scipy/sparse/sparsetools/bsr.cxx
    scipy/sparse/sparsetools/csc.cxx
    scipy/sparse/sparsetools/csr.cxx
    scipy/sparse/sparsetools/other.cxx
    scipy/sparse/sparsetools/sparsetools.cxx

    scipy/spatial/ckdtree/src/build.cxx
    scipy/spatial/ckdtree/src/count_neighbors.cxx
    scipy/spatial/ckdtree/src/cpp_exc.cxx
    scipy/spatial/ckdtree/src/globals.cxx
    scipy/spatial/ckdtree/src/query_ball_point.cxx
    scipy/spatial/ckdtree/src/query_ball_tree.cxx
    scipy/spatial/ckdtree/src/query.cxx
    scipy/spatial/ckdtree/src/query_pairs.cxx
    scipy/spatial/ckdtree/src/sparse_distances.cxx

    scipy/spatial/src/distance_wrap.c

    scipy/special/Faddeeva.cc
    scipy/special/_faddeeva.cxx
    scipy/special/_logit.c
    scipy/special/amos_wrappers.c
    scipy/special/cdf_wrappers.c
    scipy/special/sf_error.c

    scipy/special/amos/dgamln.f
    scipy/special/amos/dsclmr.f
    scipy/special/amos/fdump.f
    scipy/special/amos/zabs.f
    scipy/special/amos/zacai.f
    scipy/special/amos/zacon.f
    scipy/special/amos/zairy.f
    scipy/special/amos/zasyi.f
    scipy/special/amos/zbesh.f
    scipy/special/amos/zbesi.f
    scipy/special/amos/zbesj.f
    scipy/special/amos/zbesk.f
    scipy/special/amos/zbesy.f
    scipy/special/amos/zbinu.f
    scipy/special/amos/zbiry.f
    scipy/special/amos/zbknu.f
    scipy/special/amos/zbuni.f
    scipy/special/amos/zbunk.f
    scipy/special/amos/zdiv.f
    scipy/special/amos/zexp.f
    scipy/special/amos/zkscl.f
    scipy/special/amos/zlog.f
    scipy/special/amos/zmlri.f
    scipy/special/amos/zmlt.f
    scipy/special/amos/zrati.f
    scipy/special/amos/zs1s2.f
    scipy/special/amos/zseri.f
    scipy/special/amos/zshch.f
    scipy/special/amos/zsqrt.f
    scipy/special/amos/zuchk.f
    scipy/special/amos/zunhj.f
    scipy/special/amos/zuni1.f
    scipy/special/amos/zuni2.f
    scipy/special/amos/zunik.f
    scipy/special/amos/zunk1.f
    scipy/special/amos/zunk2.f
    scipy/special/amos/zuoik.f
    scipy/special/amos/zwrsk.f

    scipy/special/c_misc/besselpoly.c
    scipy/special/c_misc/double2.h
    scipy/special/c_misc/fsolve.c
    scipy/special/c_misc/gammaincinv.c
    scipy/special/c_misc/gammasgn.c
    scipy/special/c_misc/misc.h
    scipy/special/c_misc/poch.c
    scipy/special/c_misc/struve.c

    scipy/special/cdflib/algdiv.f
    scipy/special/cdflib/alngam.f
    scipy/special/cdflib/alnrel.f
    scipy/special/cdflib/apser.f
    scipy/special/cdflib/basym.f
    scipy/special/cdflib/bcorr.f
    scipy/special/cdflib/betaln.f
    scipy/special/cdflib/bfrac.f
    scipy/special/cdflib/bgrat.f
    scipy/special/cdflib/bpser.f
    scipy/special/cdflib/bratio.f
    scipy/special/cdflib/brcmp1.f
    scipy/special/cdflib/brcomp.f
    scipy/special/cdflib/bup.f
    scipy/special/cdflib/cdfbet.f
    scipy/special/cdflib/cdfbin.f
    scipy/special/cdflib/cdfchi.f
    scipy/special/cdflib/cdfchn.f
    scipy/special/cdflib/cdff.f
    scipy/special/cdflib/cdffnc.f
    scipy/special/cdflib/cdfgam.f
    scipy/special/cdflib/cdfnbn.f
    scipy/special/cdflib/cdfnor.f
    scipy/special/cdflib/cdfpoi.f
    scipy/special/cdflib/cdft.f
    scipy/special/cdflib/cdftnc.f
    scipy/special/cdflib/cumbet.f
    scipy/special/cdflib/cumbin.f
    scipy/special/cdflib/cumchi.f
    scipy/special/cdflib/cumchn.f
    scipy/special/cdflib/cumf.f
    scipy/special/cdflib/cumfnc.f
    scipy/special/cdflib/cumgam.f
    scipy/special/cdflib/cumnbn.f
    scipy/special/cdflib/cumnor.f
    scipy/special/cdflib/cumpoi.f
    scipy/special/cdflib/cumt.f
    scipy/special/cdflib/cumtnc.f
    scipy/special/cdflib/devlpl.f
    scipy/special/cdflib/dinvnr.f
    scipy/special/cdflib/dinvr.f
    scipy/special/cdflib/dt1.f
    scipy/special/cdflib/dzror.f
    # scipy/special/cdflib/erf.f in libf2c
    scipy/special/cdflib/erfc1.f
    scipy/special/cdflib/esum.f
    scipy/special/cdflib/exparg.f
    scipy/special/cdflib/fpser.f
    scipy/special/cdflib/gam1.f
    scipy/special/cdflib/gaminv.f
    scipy/special/cdflib/gamln.f
    scipy/special/cdflib/gamln1.f
    scipy/special/cdflib/gamma_fort.f
    scipy/special/cdflib/grat1.f
    scipy/special/cdflib/gratio.f
    scipy/special/cdflib/gsumln.f
    scipy/special/cdflib/ipmpar.f
    scipy/special/cdflib/psi_fort.f
    scipy/special/cdflib/rcomp.f
    scipy/special/cdflib/rexp.f
    scipy/special/cdflib/rlog.f
    scipy/special/cdflib/rlog1.f
    scipy/special/cdflib/spmpar.f
    scipy/special/cdflib/stvaln.f

    scipy/special/cephes/airy.c
    scipy/special/cephes/bdtr.c
    scipy/special/cephes/beta.c
    scipy/special/cephes/btdtr.c
    scipy/special/cephes/cbrt.c
    scipy/special/cephes/chbevl.c
    scipy/special/cephes/chdtr.c
    scipy/special/cephes/const.c
    scipy/special/cephes/dawsn.c
    scipy/special/cephes/ellie.c
    scipy/special/cephes/ellik.c
    scipy/special/cephes/ellpe.c
    scipy/special/cephes/ellpj.c
    scipy/special/cephes/ellpk.c
    scipy/special/cephes/exp10.c
    scipy/special/cephes/exp2.c
    scipy/special/cephes/expn.c
    scipy/special/cephes/fdtr.c
    scipy/special/cephes/fresnl.c
    scipy/special/cephes/gamma.c
    scipy/special/cephes/gdtr.c
    scipy/special/cephes/gels.c
    scipy/special/cephes/hyp2f1.c
    scipy/special/cephes/hyperg.c
    scipy/special/cephes/i0.c
    scipy/special/cephes/i1.c
    scipy/special/cephes/igam.c
    scipy/special/cephes/igami.c
    scipy/special/cephes/incbet.c
    scipy/special/cephes/incbi.c
    scipy/special/cephes/j0.c
    scipy/special/cephes/j1.c
    scipy/special/cephes/jv.c
    scipy/special/cephes/k0.c
    scipy/special/cephes/k1.c
    scipy/special/cephes/kn.c
    scipy/special/cephes/kolmogorov.c
    scipy/special/cephes/lanczos.c
    scipy/special/cephes/mtherr.c
    scipy/special/cephes/nbdtr.c
    scipy/special/cephes/ndtr.c
    scipy/special/cephes/ndtri.c
    scipy/special/cephes/pdtr.c
    scipy/special/cephes/psi.c
    scipy/special/cephes/rgamma.c
    scipy/special/cephes/round.c
    scipy/special/cephes/scipy_iv.c
    scipy/special/cephes/shichi.c
    scipy/special/cephes/sici.c
    scipy/special/cephes/sincos.c
    scipy/special/cephes/sindg.c
    scipy/special/cephes/spence.c
    scipy/special/cephes/stdtr.c
    scipy/special/cephes/struve.c
    scipy/special/cephes/tandg.c
    scipy/special/cephes/tukey.c
    scipy/special/cephes/unity.c
    scipy/special/cephes/yn.c
    scipy/special/cephes/zeta.c
    scipy/special/cephes/zetac.c

    scipy/special/mach/d1mach.f
    scipy/special/mach/i1mach.f
    scipy/special/mach/xerror.f

    scipy/special/specfun/specfun.f
    scipy/special/specfun_wrappers.c
    scipy/special/specfunmodule.c

    # mvn is disabled due to f2c compilation problems
    # see: https://mail.scipy.org/pipermail/scipy-dev/2010-January/013713.html
    # scipy/stats/mvndst.f
    # scipy/stats/mvn-f2pywrappers.f
    # scipy/stats/mvnmodule.c
    scipy/stats/statlibmodule.c
    scipy/stats/statlib/ansari.f
    scipy/stats/statlib/spearman.f
    scipy/stats/statlib/swilk.f
)

PY_SRCS(
    TOP_LEVEL

    scipy/__init__.py
    scipy/__config__.py
    scipy/version.py

    scipy/cluster/__init__.py
    scipy/cluster/hierarchy.py
    scipy/cluster/vq.py

    CYTHON_C
    scipy/cluster/_hierarchy.pyx
    scipy/cluster/_vq.pyx

    scipy/constants/__init__.py
    scipy/constants/codata.py
    scipy/constants/constants.py

    scipy/fftpack/__init__.py
    scipy/fftpack/basic.py
    scipy/fftpack/fftpack_version.py
    scipy/fftpack/helper.py
    scipy/fftpack/pseudo_diffs.py
    scipy/fftpack/realtransforms.py

    scipy/integrate/__init__.py
    scipy/integrate/quadpack.py
    scipy/integrate/quadrature.py
    scipy/integrate/_ode.py
    scipy/integrate/odepack.py
    scipy/integrate/_bvp.py

    scipy/interpolate/__init__.py
    scipy/interpolate/_cubic.py
    scipy/interpolate/fitpack2.py
    scipy/interpolate/fitpack.py
    scipy/interpolate/interpolate.py
    scipy/interpolate/interpolate_wrapper.py
    scipy/interpolate/ndgriddata.py
    scipy/interpolate/polyint.py
    scipy/interpolate/rbf.py

    CYTHON_C
    scipy/interpolate/_ppoly.pyx
    scipy/interpolate/interpnd.pyx

    scipy/io/__init__.py
    scipy/io/_fortran.py
    scipy/io/idl.py
    scipy/io/mmio.py
    scipy/io/netcdf.py
    scipy/io/wavfile.py

    scipy/io/arff/__init__.py
    scipy/io/arff/arffread.py

    scipy/io/harwell_boeing/__init__.py
    scipy/io/harwell_boeing/_fortran_format_parser.py
    scipy/io/harwell_boeing/hb.py

    scipy/io/matlab/__init__.py
    scipy/io/matlab/byteordercodes.py
    scipy/io/matlab/mio4.py
    scipy/io/matlab/mio5_params.py
    scipy/io/matlab/mio5.py
    scipy/io/matlab/miobase.py
    scipy/io/matlab/mio.py

    CYTHON_C
    scipy/io/matlab/mio5_utils.pyx
    scipy/io/matlab/mio_utils.pyx
    scipy/io/matlab/streams.pyx

    scipy/linalg/__init__.py
    scipy/linalg/basic.py
    scipy/linalg/blas.py
    scipy/linalg/calc_lwork.py
    scipy/linalg/decomp_cholesky.py
    scipy/linalg/decomp_lu.py
    scipy/linalg/_decomp_polar.py
    scipy/linalg/decomp.py
    scipy/linalg/decomp_qr.py
    scipy/linalg/_decomp_qz.py
    scipy/linalg/decomp_schur.py
    scipy/linalg/decomp_svd.py
    scipy/linalg/_expm_frechet.py
    scipy/linalg/flinalg.py
    scipy/linalg/_interpolative_backend.py
    scipy/linalg/interpolative.py
    scipy/linalg/lapack.py
    scipy/linalg/linalg_version.py
    scipy/linalg/_matfuncs_inv_ssq.py
    scipy/linalg/matfuncs.py
    scipy/linalg/_matfuncs_sqrtm.py
    scipy/linalg/misc.py
    scipy/linalg/_procrustes.py
    scipy/linalg/_solvers.py
    scipy/linalg/special_matrices.py

    CYTHON_C
    scipy/linalg/_solve_toeplitz.pyx
    scipy/linalg/cython_lapack.pyx
    scipy/linalg/cython_blas.pyx
    scipy/linalg/_decomp_update.pyx

    scipy/_lib/__init__.py
    scipy/_lib/_gcutils.py
    scipy/_lib/_numpy_compat.py
    # scipy/_lib/_testutils.py
    scipy/_lib/_threadsafety.py
    scipy/_lib/_tmpdirs.py
    scipy/_lib/_util.py
    scipy/_lib/_version.py
    scipy/_lib/decorator.py
    scipy/_lib/six.py

    scipy/misc/__init__.py
    scipy/misc/common.py
    scipy/misc/doccer.py
    scipy/misc/pilutil.py

    scipy/ndimage/__init__.py
    scipy/ndimage/filters.py
    scipy/ndimage/fourier.py
    scipy/ndimage/interpolation.py
    scipy/ndimage/io.py
    scipy/ndimage/measurements.py
    scipy/ndimage/morphology.py
    scipy/ndimage/_ni_support.py

    scipy/odr/add_newdocs.py
    scipy/odr/__init__.py
    scipy/odr/models.py
    scipy/odr/odrpack.py

    scipy/optimize/__init__.py
    scipy/optimize/_basinhopping.py
    scipy/optimize/cobyla.py
    scipy/optimize/_differentialevolution.py
    scipy/optimize/_hungarian.py
    scipy/optimize/lbfgsb.py
    scipy/optimize/linesearch.py
    scipy/optimize/_linprog.py
    scipy/optimize/_lsq/bvls.py
    scipy/optimize/_lsq/common.py
    scipy/optimize/_lsq/dogbox.py
    scipy/optimize/_lsq/__init__.py
    scipy/optimize/_lsq/least_squares.py
    scipy/optimize/_lsq/lsq_linear.py
    scipy/optimize/_lsq/trf_linear.py
    scipy/optimize/_lsq/trf.py
    scipy/optimize/_minimize.py
    scipy/optimize/minpack.py
    scipy/optimize/nnls.py
    scipy/optimize/nonlin.py
    scipy/optimize/_numdiff.py
    scipy/optimize/optimize.py
    scipy/optimize/_root.py
    scipy/optimize/slsqp.py
    scipy/optimize/_spectral.py
    scipy/optimize/tnc.py
    scipy/optimize/_trustregion_dogleg.py
    scipy/optimize/_trustregion_ncg.py
    scipy/optimize/_trustregion.py
    scipy/optimize/_tstutils.py
    scipy/optimize/zeros.py

    CYTHON_CPP
    scipy/optimize/_lsq/givens_elimination.pyx

    CYTHON_C
    scipy/optimize/_group_columns.pyx

    scipy/signal/__init__.py
    scipy/signal/_arraytools.py
    scipy/signal/bsplines.py
    scipy/signal/filter_design.py
    scipy/signal/fir_filter_design.py
    scipy/signal/lti_conversion.py
    scipy/signal/ltisys.py
    scipy/signal/_max_len_seq.py
    scipy/signal/_peak_finding.py
    scipy/signal/_savitzky_golay.py
    scipy/signal/signaltools.py
    scipy/signal/spectral.py
    scipy/signal/_upfirdn.py
    scipy/signal/waveforms.py
    scipy/signal/wavelets.py
    scipy/signal/windows.py

    CYTHON_C
    scipy/signal/_max_len_seq_inner.pyx
    scipy/signal/_spectral.pyx
    scipy/signal/_upfirdn_apply.pyx

    scipy/sparse/__init__.py
    scipy/sparse/compressed.py
    scipy/sparse/spfuncs.py
    scipy/sparse/sputils.py
    scipy/sparse/lil.py
    scipy/sparse/csr.py
    scipy/sparse/sparsetools.py
    scipy/sparse/dok.py
    scipy/sparse/extract.py
    scipy/sparse/data.py
    scipy/sparse/dia.py
    scipy/sparse/construct.py
    scipy/sparse/coo.py
    scipy/sparse/csc.py
    scipy/sparse/_matrix_io.py
    scipy/sparse/base.py
    scipy/sparse/bsr.py

    CYTHON_C
    scipy/sparse/_csparsetools.pyx

    scipy/sparse/csgraph/__init__.py
    scipy/sparse/csgraph/_laplacian.py
    scipy/sparse/csgraph/_components.py
    scipy/sparse/csgraph/_validation.py

    CYTHON_CPP
    scipy/sparse/csgraph/_min_spanning_tree.pyx
    scipy/sparse/csgraph/_reordering.pyx
    scipy/sparse/csgraph/_shortest_path.pyx
    scipy/sparse/csgraph/_tools.pyx
    scipy/sparse/csgraph/_traversal.pyx

    scipy/sparse/linalg/__init__.py
    scipy/sparse/linalg/interface.py
    scipy/sparse/linalg/_onenormest.py
    scipy/sparse/linalg/matfuncs.py
    scipy/sparse/linalg/_norm.py
    scipy/sparse/linalg/_expm_multiply.py

    scipy/sparse/linalg/dsolve/__init__.py
    scipy/sparse/linalg/dsolve/linsolve.py
    scipy/sparse/linalg/dsolve/_add_newdocs.py

    scipy/sparse/linalg/eigen/__init__.py
    scipy/sparse/linalg/eigen/arpack/__init__.py
    scipy/sparse/linalg/eigen/arpack/arpack.py
    scipy/sparse/linalg/eigen/lobpcg/__init__.py
    scipy/sparse/linalg/eigen/lobpcg/lobpcg.py

    scipy/sparse/linalg/isolve/__init__.py
    scipy/sparse/linalg/isolve/lsqr.py
    scipy/sparse/linalg/isolve/minres.py
    scipy/sparse/linalg/isolve/lgmres.py
    scipy/sparse/linalg/isolve/iterative.py
    scipy/sparse/linalg/isolve/utils.py
    scipy/sparse/linalg/isolve/lsmr.py

    scipy/spatial/__init__.py
    scipy/spatial/distance.py
    scipy/spatial/kdtree.py
    scipy/spatial/_plotutils.py
    scipy/spatial/_procrustes.py
    scipy/spatial/_spherical_voronoi.py

    CYTHON_C
    scipy/spatial/qhull.pyx

    CYTHON_CPP
    scipy/spatial/ckdtree.pyx

    scipy/special/__init__.py
    scipy/special/lambertw.py
    scipy/special/orthogonal.py
    scipy/special/_ellip_harm.py
    scipy/special/basic.py
    scipy/special/spfun_stats.py
    # scipy/special/_testutils.py
    # scipy/special/_mptestutils.py
    scipy/special/add_newdocs.py
    scipy/special/_spherical_bessel.py

    scipy/special/_precompute/__init__.py
    scipy/special/_precompute/expn_asy.py
    scipy/special/_precompute/gammainc_asy.py
    scipy/special/_precompute/utils.py

    CYTHON_C
    scipy/special/_comb.pyx
    scipy/special/_ufuncs.pyx
    scipy/special/_ellip_harm_2.pyx

    CYTHON_CPP
    scipy/special/_ufuncs_cxx.pyx

    scipy/stats/__init__.py
    scipy/stats/_distr_params.py
    scipy/stats/kde.py
    scipy/stats/mstats.py
    scipy/stats/distributions.py
    scipy/stats/vonmises.py
    scipy/stats/_continuous_distns.py
    scipy/stats/contingency.py
    scipy/stats/_stats_mstats_common.py
    scipy/stats/_multivariate.py
    scipy/stats/mstats_extras.py
    scipy/stats/morestats.py
    scipy/stats/_tukeylambda_stats.py
    scipy/stats/_distn_infrastructure.py
    scipy/stats/mstats_basic.py
    scipy/stats/_constants.py
    scipy/stats/stats.py
    scipy/stats/_binned_statistic.py
    scipy/stats/_discrete_distns.py

    CYTHON_CPP
    scipy/stats/_stats.pyx
)

PY_REGISTER(
    scipy.fftpack._fftpack
    scipy.fftpack.convolve

    scipy.integrate._odepack
    scipy.integrate._quadpack
    scipy.integrate.vode
    scipy.integrate._dop
    scipy.integrate.lsoda

    scipy.interpolate._fitpack
    scipy.interpolate.dfitpack
    scipy.interpolate._interpolate

    scipy.linalg._fblas
    scipy.linalg._flapack
    scipy.linalg._calc_lwork
    scipy.linalg._flinalg
    scipy.linalg._interpolative

    scipy.ndimage._nd_image

    scipy.odr.__odrpack

    scipy.optimize._cobyla
    scipy.optimize._lbfgsb
    scipy.optimize._minpack
    scipy.optimize._nnls
    scipy.optimize._slsqp
    scipy.optimize._zeros
    scipy.optimize.minpack2
    scipy.optimize.moduleTNC

    scipy.signal.sigtools
    scipy.signal.spline

    scipy.sparse._sparsetools
    scipy.sparse.linalg.dsolve._superlu
    scipy.sparse.linalg.eigen.arpack._arpack
    scipy.sparse.linalg.isolve._iterative

    scipy.spatial._distance_wrap

    scipy.special.specfun

    scipy.stats.statlib
    # mvn is disabled due to f2c compilation problems
    # see: https://mail.scipy.org/pipermail/scipy-dev/2010-January/013713.html
    # scipy.stats.mvn
)

# _cytest.pyx and _ni_label.pyx are expected to be importable as scipy.ndimage._cytest and scipy.ndimage._ni_label correspondingly,
# yet the source files are placed into src subdirectory.
#
# Workaround this by manual SRCDIR and NAMESPACE management.

SRCDIR(
    contrib/python/scipy/scipy/ndimage/src
)

PY_SRCS(
    NAMESPACE scipy.ndimage

    CYTHON_CPP
    _cytest.pyx
    _ni_label.pyx
)

ENDIF (SCIPY12)

END()

RECURSE(
    py2
    scipy/linalg/src/lapack_deprecations
)

RECURSE_FOR_TESTS(
    scipy/_build_utils/tests
    scipy/cluster/tests
    scipy/constants/tests
    scipy/fftpack/tests
    scipy/integrate/tests
    scipy/interpolate/tests
    scipy/io/arff/tests
    scipy/io/harwell_boeing/tests
    scipy/io/matlab/tests
    scipy/io/tests
    scipy/_lib/tests
    scipy/linalg/tests
    scipy/misc/tests
    scipy/ndimage/tests
    scipy/odr/tests
    scipy/optimize/tests
    scipy/signal/tests
    scipy/sparse/csgraph/tests
    scipy/sparse/linalg/dsolve/tests
    scipy/sparse/linalg/eigen/arpack/tests
    scipy/sparse/linalg/eigen/lobpcg/tests
    scipy/sparse/linalg/isolve/tests
    scipy/sparse/linalg/tests
    scipy/sparse/tests
    scipy/spatial/tests
    scipy/special/tests
    scipy/stats/tests
)
