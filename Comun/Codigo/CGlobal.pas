unit CGlobal;

interface

type
  TProgramVersion = (pvBAG, pvSAT );

const
  //para controlar las actualizaciones se realizen
  kVersion = 1;


var
  gProgramVersion: TProgramVersion = pvBAG;
  gsInterPlanta: string = 'IP';

implementation

end.
