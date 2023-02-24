      program prgm_02_01
!
!     This program carries out calculation of 1D particle-in-a-box values.
!     Specifically, the user provides the particle mass, box length, and quantum
!     numbers for two canonical PIB eigenstates.
!
!     This program is written in atomic units.
!     Abigail Gyamfi, CHEM 225 Spring 2023
!
!
!     Variable Declarations
      implicit none
      integer::i,NCmdLineArgs
      real::m,l,tMatrixElement
      real,external::PIB_1D_T_Element
      integer::n1,n2
      logical::fail
      character(len=1024)::cmd_buffer
!
!     Format Statements
!
 2000 format(1x,'Kinetic energy matrix element ',I5,',',I5,' is ',F12.5,'.')
 9000 format(1x,'Expected 4 command line arguments, but found ',i2,'.')
!
!
!     NB: For KE: the 4 input arguments/parameters are m, l, n1, and n2.
!     Read in m, l, n1, and n2 from the command line.
!
      NCmdLineArgs = command_argument_count()
      if(NCmdLineArgs.ne.4) then
        write(*,9000) NCmdLineArgs
        fail = .true.
      endIf
      if(fail) goto 999
      call Get_Command_Argument(1,cmd_buffer)
      read(cmd_buffer,*) m
      call Get_Command_Argument(2,cmd_buffer)
      read(cmd_buffer,*) l
      call Get_Command_Argument(3,cmd_buffer)
      read(cmd_buffer,*) n1
      call Get_Command_Argument(4,cmd_buffer)
      read(cmd_buffer,*) n2
!
!     Given the input parameters, evaluate the kinetic energy integral between
!     particle-in-a-box eigenfunctions n1 and n2.
!
      tMatrixElement = PIB_1D_T_Element(l,n1,n2)
      write(*,2000) n1,n2,tMatrixElement
!
!     The end of the job...
!
  999 continue
      end program prgm_02_01

!     The function should be a Real Function named PIB_1D_T_Element

      real function PIB_1D_T_Element(l,n1,n2)
!
!     This function evaluates the kinetic energy matrix element < n1 | T | n2 >,
!     where n1 and n2 are particle-in-a-box eigenstate labels and T is the
!     kinetic energy operator.
!
!
!     Variable Declarations
      implicit none
      real,intent(in)::l
      integer,intent(in)::n1,n2
      real::prefactor
!
!     The case where n1=n2 is different than n1\=n2. For this reason, we use an
!     if block to separate the evaluation of the kinetic energy integral for
!     these two different cases.
!
      if(n1.eq.n2) then
!     NB: when n1 = n2
      PIB_1D_T_Element = (n1**2)/(2*l**2)

      else
!     NB: when n1\=n2
      PIB_1D_T_Element = 0

      endIf
!
      end function PIB_1D_T_Element
