      SUBROUTINE DFFTI (N,WSAVE)
	IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      DIMENSION       WSAVE(*)
      IF (N .EQ. 1) RETURN
      CALL DFFTI1 (N,WSAVE(N+1),WSAVE(2*N+1))
      RETURN
      END
