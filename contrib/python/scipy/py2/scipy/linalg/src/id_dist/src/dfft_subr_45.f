      SUBROUTINE DSINQI (N,WSAVE)
	IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      DIMENSION       WSAVE(*)
      CALL DCOSQI (N,WSAVE)
      RETURN
      END

