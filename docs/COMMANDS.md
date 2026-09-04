# Command reference

## Shared behavior

Every command opens and closes one Undo mark. Cancelled input leaves no intentional drawing changes. Unexpected errors close open CSV handles and end the Undo mark. Labels use the current text style and fixed height `2.5` in drawing units.

Coordinates used for calculations and CSV exchange are WCS values. Commands do not change the current layer, UCS, text style, units, or network state.

## CTCOORD

Select POINT entities. The command adds sequential `P1`, `P2`, ... labels on layer `ACT-COORD` with WCS X/Y/Z values.

## CTEXPORT

Select POINT and TEXT entities, then choose a CSV path. The schema is `id,type,x,y,z,note`. Text fields are quoted and embedded quotes are doubled. Output uses the host CAD text encoding.

## CTIMPORT

Choose a CSV file whose header contains case-insensitive `x`, `y`, and `z` columns in any order. Extra columns are ignored. Valid WCS rows create POINT entities on `ACT-IMPORT`; invalid rows are counted and skipped. `examples/import-points.csv` is a safe synthetic fixture.

## CTELEV

Select one POINT and enter an elevation. The command creates or updates an `EL=` label on `ACT-ELEV` at that point in the current model/layout space.

## CTCHAINAGE

Select an alignment curve, then POINT entities. The command uses the closest curve point and distance from the curve start to create `CH=` and `OFF=` labels on `ACT-CHAINAGE`. Offset is an unsigned 3D distance.

## CTINTERP

Select two control POINT entities, then target POINT entities. The controls' WCS Z values are linearly interpolated from each target's projected position in the WCS XY plane. Ratios are clamped from 0 to 1. Labels are written on `ACT-ELEV`; POINT geometry is not moved.

## CTPROFILE

Select an alignment curve, POINT entities, and a table insertion point. Rows are sorted by real distance from the curve start. The table fields are `CHAINAGE,ELEVATION,X,Y,ABS_OFFSET`. The picked table origin and row offsets are interpreted in the current UCS, then stored in WCS.
