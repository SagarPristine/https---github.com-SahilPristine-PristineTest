// table 50013 "Marketing Indent Line"
// {

//     fields
//     {
//         field(1; "Document No."; Code[20])
//         {
//             Caption = 'Document No.';
//             DataClassification = ToBeClassified;
//             TableRelation = "Marketing Indent Header".No.;
//         }
//         field(2;"Line No.";Integer)
//         {
//             Caption = 'Line No.';
//             DataClassification = ToBeClassified;
//         }
//         field(3;"Crop Code";Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Crop Master".Code;
//         }
//         field(4;"Variety Group";Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Item Group Master"."Item Code" WHERE (Class of Seeds=FILTER(TL));
//             ValidateTableRelation = false;

//             trigger OnValidate()
//             var
//                 rec50043: Record "50043";
//             begin
//                 rec50043.RESET;
//                 rec50043.SETCURRENTKEY("Document No.","Variety Group","Line No.");
//                 rec50043.SETRANGE("Document No.",Rec."Document No.");
//                 rec50043.SETRANGE("Variety Group",Rec."Variety Group");
//                 IF rec50043.FINDFIRST THEN
//                   ERROR('You Cannot select same Variety Group twice.');

//                 // IF "Variety Group"<>'' THEN
//                 //  BEGIN
//                 //    RecItem.RESET;
//                 //    RecItem.SETRANGE(Description,"Variety Group");
//                 //    IF RecItem.FINDSET THEN
//                 //      REPEAT
//                 //        Rec."Item No.":=RecItem."No.";
//                 //      UNTIL RecItem.NEXT=0;
//                 //  END;
//             end;
//         }
//         field(5;"Booking Qty.";Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(6;"No. of Alloted Qty.";Decimal)
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 // IF Rec."No. of Alloted Qty." <> 0 THEN
//                 //   Rec."Alloted %" := ROUND(((Rec."No. of Alloted Qty." * 100)/Rec."Booking Qty."),1,'>')
//                 //  ELSE
//                 //  Rec."Alloted %" := 0;
//             end;
//         }
//         field(7;"Do Created";Boolean)
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(8;Posted;Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(9;"Alloted %";Decimal)
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 CLEAR(VarData);

//                 IF Rec."Alloted %" <> 0 THEN
//                   BEGIN
//                     VarData:= ROUND(((Rec."Alloted %" * Rec."No. of Bags")/100),1,'>');
//                     Rec."Alloted No. of Bags":=VarData;
//                     Rec."No. of Alloted Qty." :=VarData*Rec."FG Pack Size";
//                   END
//                 ELSE
//                   Rec."No. of Alloted Qty." := 0;
//             end;
//         }
//         field(10;"No. of Bags";Integer)
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin

//                 IF Rec."No. of Bags" <> 0 THEN
//                   Rec."Booking Qty.":=Rec."FG Pack Size" * Rec."No. of Bags"
//                 ELSE
//                   Rec."Booking Qty.":=0;
//             end;
//         }
//         field(11;"FG Pack Size";Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(12;Description;Text[40])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(13;"Booking Qty";Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(14;"Booking Rate per Bags";Decimal)
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 IF Rec."Booking Rate per Bags"<>0 THEN
//                   Rec."Booking Value per Bags":=Rec."No. of Bags" * "Booking Rate per Bags"
//                 ELSE
//                   Rec."Booking Value per Bags":=0;
//             end;
//         }
//         field(15;"Booking Value per Bags";Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(16;"Item No.";Code[30])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Item.No. WHERE (Item Group=FIELD(Variety Group),
//                                             FG Pack Size=FILTER(<>0));

//             trigger OnValidate()
//             begin
//                 IF RecItem.GET("Item No.") THEN
//                   BEGIN
//                     Rec.Description:=RecItem.Description;
//                     Rec."FG Pack Size":=RecItem."FG Pack Size";
//                   END;
//             end;
//         }
//         field(17;"Alloted No. of Bags";Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(18;"Booking Rate per kg";Decimal)
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 IF Rec."Booking Rate per kg"<>0 THEN
//                   Rec."Booking Value per Kg":= ROUND(Rec."Booking Qty." * "Booking Rate per kg",1,'=')
//                 ELSE
//                   Rec."Booking Value per Kg":=0;

//                 IF Rec."Booking Value per Kg" <> 0 THEN BEGIN
//                   VALIDATE("Booking Rate per Bags","Booking Rate per kg"*"FG Pack Size");
//                 END ELSE Rec."Booking Value per Bags" := 0;
//             end;
//         }
//         field(19;"Booking Value per Kg";Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(20;"DO Created Qty";Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(21;"Balance Qty";Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(22;"Item Name";Text[50])
//         {
//             CalcFormula = Lookup(Item.Description WHERE (No.=FIELD(Item No.)));
//             FieldClass = FlowField;
//         }
//     }

//     keys
//     {
//         key(Key1;"Document No.","Line No.")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         RecItem: Record "27";
//         VarData: Decimal;
// }

