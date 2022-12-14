VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Suelld4"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public rsReg04 As ADODB.Recordset

Private Sub Class_GetDataMember(DataMember As String, Data As Object)
  Set Data = rsReg04
End Sub

Private Sub Class_Initialize()

   Dim fld As ADODB.field
   Dim strRow As String * 475
   Dim strField As String
   Dim intPos As Integer

   Set rsReg04 = New ADODB.Recordset

   With rsReg04
      .Fields.Append "Inicio", adChar, 1, adFldUpdatable
      .Fields.Append "Reg04", adChar, 370, adFldUpdatable
      .Fields.Append "TipoLiq", adChar, 1, adFldUpdatable
      .Fields.Append "Periodo", adChar, 4, adFldUpdatable
      .Fields.Append "NroLiq", adChar, 5, adFldUpdatable
      .Fields.Append "Legajo", adChar, 5, adFldUpdatable
      .Fields.Append "Nombre", adChar, 24, adFldUpdatable
      .Fields.Append "Filler02", adChar, 63, adFldUpdatable
      .Fields.Append "Final", adChar, 2, adFldUpdatable
      
      ' Utilice el tipo de cursor Keyset para permitir la actualización
      ' de los registros.
      .CursorType = adOpenKeyset
      .LockType = adLockOptimistic
      .Open
   End With
   
   Open sCarpeta & "\SuellD4.arc" For Input As #1
   Line Input #1, strRow

   Do Until EOF(1)
        
        Line Input #1, strRow
        With rsReg04
         
            If Mid(strRow, 1, 1) <> "*" Then
                
                .AddNew
                
                For Each fld In .Fields
                    strField = strRow
                    fld.value = Mid(strField, 1, fld.DefinedSize)
                
                    ' Elimina el texto del campo de la fila de texto.
                    strRow = Right(strRow, Len(strRow) - fld.DefinedSize)
                Next
                .Update
                .MoveFirst
            
            End If
            
        End With
        
   Loop
      
   Close #1

End Sub




Public Sub GuardarEnArchivo()

'    Dim fld As ADODB.field
'    Dim strRow As String
'    Dim strField As String
'    Dim iReg As Long
'
'    Open SGSUEL & "\sue103.arc" For Output As #1
'
'    With rsPersonal
'
'      .MoveFirst
'      iReg = 1
'      Do While Not .EOF
'
'         For Each fld In .Fields
'            ' Si un campo tiene un valor, agrega comillas.
'            If Len(fld.value) > 0 Then
'                strField = fld.value
'            Else
'                strField = Space(fld.DefinedSize)
'            End If
'            ' Agrega el valor del campo y un delimitador de tabulación
'            ' a la cadena de salida.
'            strRow = strRow & strField
'        Next
'        ' Imprime la cadena de salida.
''       Seek #1, iReg  ' Establece la posición.
'        Print #1, strRow
'
'        strRow = ""
'        .MoveNext
'        iReg = iReg + 1
'
'      Loop
'
'   End With
'
'   Close

End Sub




