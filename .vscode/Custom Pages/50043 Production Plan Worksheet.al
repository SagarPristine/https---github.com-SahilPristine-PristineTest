// #pragma warning disable
// page 50043 "Production Plan Worksheet"
// {
//     Caption = 'Production Planning';
//     PageType = Worksheet;
//     SourceTable = "Production Plan Line";
//     ApplicationArea = All;
//     UsageCategory = Lists;
//     AutoSplitKey = true;
//     DelayedInsert = true;

//     layout
//     {
//         area(content)
//         {
//             field("Production Plan No."; Rec."Production Plan No.")
//             {
//                 ApplicationArea = All;
//                 Style = Favorable;
//                 trigger OnValidate()
//                 var
//                 begin

//                 end;

//                 trigger OnLookup(var Text: Text): Boolean
//                 var
//                     ProductionPlanHeader: Record "Production Plan Header";
//                 begin
//                     CurrPage.SAVERECORD;
//                     IF PAGE.RUNMODAL(PAGE::"Production Plan Lists", ProductionPlanHeader) = ACTION::LookupOK THEN BEGIN
//                         "Production Plan No." := ProductionPlanHeader."Production Plan No.";
//                         Season := ProductionPlanHeader.Season;
//                     END;
//                     CurrPage.UPDATE(FALSE);

//                 end;
//             }
//             field(Season; Season)
//             {
//                 ApplicationArea = all;
//                 Style = Favorable;
//                 trigger OnValidate()
//                 var
//                 begin
//                     SetDate();
//                 end;
//             }
//             repeater(General)
//             {
//                 field("Line No."; "Line No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Variety; Variety)
//                 {
//                     ApplicationArea = all;
//                     Style = Favorable;
//                 }
//                 field("Dynamic Column 1"; "Dynamic Column 1")
//                 {
//                     ApplicationArea = all;
//                     CaptionClass = '1,5,,' + Dynamiccolumn1;
//                     Style = Strong;


//                 }
//                 field("Dynamic Column 2"; "Dynamic Column 2")
//                 {
//                     ApplicationArea = All;
//                     CaptionClass = '1,5,,' + Dynamiccolumn2;

//                 }
//                 field("Dynamic Column 3"; "Dynamic Column 3")
//                 {
//                     ApplicationArea = All;
//                     CaptionClass = '1,5,,' + Dynamiccolumn3;

//                 }
//                 field("Buffer for Storage"; "Buffer for Storage")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("Adjustments (if any)"; "Adjustments (if any)")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("Dynamic Column 4"; "Dynamic Column 4")
//                 {
//                     ApplicationArea = All;
//                     CaptionClass = '1,5,,' + Dynamiccolumn4;
//                     Style = Subordinate;

//                 }
//                 field("Dynamic Column 5"; "Dynamic Column 5")
//                 {
//                     ApplicationArea = All;
//                     CaptionClass = '1,5,,' + Dynamiccolumn5;
//                     Style = Subordinate;

//                 }
//                 field("Dynamic Column 6"; "Dynamic Column 6")
//                 {
//                     ApplicationArea = All;
//                     CaptionClass = '1,5,,' + Dynamiccolumn6;
//                     Style = Subordinate;

//                 }
//                 field("Dynamic Column 7"; "Dynamic Column 7")
//                 {
//                     ApplicationArea = All;
//                     CaptionClass = '1,5,,' + Dynamiccolumn7;
//                     Style = Subordinate;

//                 }
//                 field("Kharif Shortfall Qty"; "Kharif Shortfall Qty")
//                 {
//                     ApplicationArea = All;
//                     Style = Subordinate;

//                 }
//                 field("Dynamic Column 8"; "Dynamic Column 8")
//                 {
//                     ApplicationArea = All;
//                     CaptionClass = '1,5,,' + Dynamiccolumn8;
//                     Style = StrongAccent;

//                 }
//                 field("Dynamic Column 9"; "Dynamic Column 9")
//                 {
//                     ApplicationArea = All;
//                     CaptionClass = '1,5,,' + Dynamiccolumn9;
//                     Style = StrongAccent;
//                 }
//                 field("Dynamic Column 10"; "Dynamic Column 10")
//                 {
//                     ApplicationArea = All;
//                     CaptionClass = '1,5,,' + Dynamiccolumn10;
//                     Style = StrongAccent;

//                 }
//                 field("Dynamic Column 11"; "Dynamic Column 11")
//                 {
//                     ApplicationArea = All;
//                     CaptionClass = '1,5,,' + Dynamiccolumn11;
//                     Style = StrongAccent;

//                 }
//                 field("Rabi Shortfall Qty"; "Rabi Shortfall Qty")
//                 {
//                     ApplicationArea = All;
//                     Style = StrongAccent;

//                 }

//             }
//         }
//     }
//     trigger OnAfterGetRecord()
//     var
//     begin
//         SetDate();
//     end;




//     local procedure SetDate()
//     var
//         SeasonMaster: Array[3] of Record "Season Master";
//     begin
//         Clear(Dynamiccolumn1);
//         Clear(Dynamiccolumn2);
//         Clear(Dynamiccolumn3);
//         Clear(Dynamiccolumn4);
//         Clear(Dynamiccolumn5);
//         Clear(Dynamiccolumn6);
//         Clear(Dynamiccolumn7);
//         Clear(Dynamiccolumn8);
//         Clear(Dynamiccolumn9);
//         Clear(Dynamiccolumn10);
//         Clear(Dynamiccolumn11);
//         if Season <> '' then begin
//             SeasonMaster[1].Reset();
//             SeasonMaster[1].SetRange("Season Code", Season);
//             SeasonMaster[1].FindFirst();
//             Dynamiccolumn1 := SeasonMaster[1]."Season Code" + ' ' + 'Sales Plan';
//             SeasonMaster[2].Reset();
//             SeasonMaster[2].SetRange(Sequence, SeasonMaster[1].Sequence + 1);
//             SeasonMaster[2].FindLast();
//             Dynamiccolumn2 := SeasonMaster[2]."Season Code" + ' ' + 'Sales Plan';
//             SeasonMaster[3].Reset();
//             SeasonMaster[3].SetRange(Sequence, SeasonMaster[2].Sequence + 1);
//             SeasonMaster[3].FindLast();
//             Dynamiccolumn3 := SeasonMaster[3]."Season Code" + ' ' + 'Sales Plan';
//             Dynamiccolumn4 := 'Inventory in Hand before K22 Prod. + Inventory Exp. from R21 + K22 SR Exp.';
//             Dynamiccolumn5 := 'K22 Production Plan for R22';
//             Dynamiccolumn6 := 'K22 Production Plan for K23';
//             Dynamiccolumn7 := 'Total K22 Production Plan';
//             Dynamiccolumn8 := 'Inventory in Hand before R22 Prod. + Inventory Exp. from K22 Prod.';
//             Dynamiccolumn9 := 'R22 Prod. for K23 + Buffer (K23 Sales Plan - Exp. Inventory in Hand before R22)';
//             Dynamiccolumn10 := 'R22 Production for R23';
//             Dynamiccolumn11 := 'Total R22 Production Plan';
//         end;
//         CurrPage.Update();
//     end;

//     procedure SetValues(ProductionPlanHeader: Record "Production Plan Header");
//     var
//         myInt: Integer;
//         Productionplanline: Record "Production Plan Line";
//     begin
//         VarSeason := ProductionPlanHeader.Season;

//     end;

//     var
//         VarSeason: Code[20];
//         Dynamiccolumn1, Dynamiccolumn2, Dynamiccolumn3, Dynamiccolumn4, Dynamiccolumn5, Dynamiccolumn6, Dynamiccolumn7, Dynamiccolumn8, Dynamiccolumn9, Dynamiccolumn10, Dynamiccolumn11 : Text[150];

// }
