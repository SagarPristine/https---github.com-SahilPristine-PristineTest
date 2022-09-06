// table 50012 "Marketing Indent Header"
// {
//     LookupPageID = 50091;

//     fields
//     {
//         field(1; "No."; Code[20])
//         {
//             Caption = 'No.';
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 // IF "No." <> xRec."No." THEN BEGIN
//                 //     recUL.RESET;
//                 //     recUL.SETCURRENTKEY("User ID");
//                 //     recUL.SETRANGE("User ID", USERID);
//                 //     recUL.SETRANGE("Marketing Indent", TRUE);
//                 //     IF recUL.FINDFIRST THEN BEGIN
//                 //         IF recLoc.GET(recUL."Location Code") THEN BEGIN
//                 //             recLoc.TESTFIELD("Marketing Indent No. Series");
//                 //             NoSeriesMgt.TestManual(recLoc."Marketing Indent No. Series");
//                 //             "No. Series" := '';
//                 //         END ELSE
//                 //             ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Marketing Indent No. Series"));
//                 //     END ELSE
//                 //         ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
//                 // END;
//             end;
//         }
//         field(2; Date; Date)
//         {
//             Caption = 'Date';
//             DataClassification = ToBeClassified;
//         }
//         field(3; Posted; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(4; Season; Code[10])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Season Master"."Season Code";

//             trigger OnValidate()
//             begin
//                 //checking already generated Season/Customer Wise
//                 CheckCustomerAndSeasonAlreadyExists;
//             end;
//         }
//         field(5; "No. Series"; Code[20])
//         {
//             Caption = 'No. Series';
//             DataClassification = ToBeClassified;
//             Editable = false;
//             TableRelation = "No. Series";
//         }
//         field(6; "Customer No."; Code[20])
//         {
//             Caption = 'No.';
//             DataClassification = ToBeClassified;
//             TableRelation = Customer.No.;

//             trigger OnValidate()
//             begin
//                 //checking already generated Season/Customer Wise
//                 CheckCustomerAndSeasonAlreadyExists;
//                 Customer.RESET;
//                 Customer.GET("Customer No.");
//                 "Customer Name" := Customer.Name;
//                 IF SalespersonPurchaser.GET(Customer."Salesperson Code") THEN BEGIN
//                    "Sales Person Name" := SalespersonPurchaser.Name;
//                     "Salesperson Code" := SalespersonPurchaser.Code;
//                     END;
//                 IF "Customer No." = '' THEN
//                    "Sales Person Name" := '';
//             end;
//         }
//         field(7;Name;Text[50])
//         {
//             CalcFormula = Lookup(Customer.Name WHERE (No.=FIELD(Customer No.)));
//             Caption = 'Name';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(8;"Name 2";Text[50])
//         {
//             CalcFormula = Lookup(Customer."Name 2" WHERE (No.=FIELD(Customer No.)));
//             Caption = 'Name 2';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(9;Address;Text[50])
//         {
//             CalcFormula = Lookup(Customer.Address WHERE (No.=FIELD(Customer No.)));
//             Caption = 'Address';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(10;"Address 2";Text[50])
//         {
//             CalcFormula = Lookup(Customer."Address 2" WHERE (No.=FIELD(Customer No.)));
//             Caption = 'Address 2';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(11;Zone;Code[20])
//         {
//             CalcFormula = Lookup(Customer.Zone WHERE (No.=FIELD(Customer No.)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(12;State;Code[20])
//         {
//             CalcFormula = Lookup(Customer."State Code" WHERE (No.=FIELD(Customer No.)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(13;Region;Code[20])
//         {
//             CalcFormula = Lookup(Customer."Region Code" WHERE (No.=FIELD(Customer No.)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(14;District;Code[20])
//         {
//             CalcFormula = Lookup(Customer."District Code" WHERE (No.=FIELD(Customer No.)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(15;Taluka;Code[20])
//         {
//             CalcFormula = Lookup(Customer.Taluka WHERE (No.=FIELD(Customer No.)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(16;Location;Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Location.Code;

//             trigger OnValidate()
//             var
//                 ProcessTransferPostYesNo: Codeunit 50000;
//             begin
//                 //Nakul@PBS
//                 ProcessTransferPostYesNo.UserLocation(Rec.Location);
//                 //Nakul@PBS
//             end;
//         }
//         field(17;"Sales Person Name";Text[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(18;"Salesperson Code";Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(19;"Customer Name";Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//     }

//     keys
//     {
//         key(Key1;"No.")
//         {
//             Clustered = true;
//         }
//         key(Key2;"Customer Name")
//         {
//         }
//     }

//     fieldgroups
//     {
//         fieldgroup(DropDown;"No.","Customer Name")
//         {
//         }
//     }

//     trigger OnInsert()
//     begin
//         IF "No." = '' THEN BEGIN
//           //checking already generated Season/Customer Wise
//         //  CheckCustomerAndSeasonAlreadyExists;

//           recUL.RESET;
//           recUL.SETCURRENTKEY("User ID");
//           recUL.SETRANGE("User ID",USERID);
//           recUL.SETRANGE("Marketing Indent",TRUE);
//           recUL.SETRANGE("Location Code",'LOC0036');
//           IF recUL.FINDFIRST THEN BEGIN
//             IF recLoc.GET(recUL."Location Code") THEN BEGIN
//               recLoc.TESTFIELD("Marketing Indent No. Series");
//               NoSeriesMgt.InitSeries(recLoc."Marketing Indent No. Series",xRec."No. Series",0D,"No.","No. Series");
//               Rec.Location := recUL."Location Code";
//             END ELSE
//               ERROR('Location Code %1 %2 ''. It cannot be Blank.',recUL."Location Code",recLoc.FIELDCAPTION("Marketing Indent No. Series"));
//           END ELSE
//             ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
//         END;
//     end;

//     var
//         NoSeriesMgt: Codeunit 396;
//         recUL: Record 50015;
//         recLoc: Record 14;
//         SalespersonPurchaser: Record 13;
//         Customer: Record 18;

//     procedure CheckCustomerAndSeasonAlreadyExists()
//     var
//         rec50042: Record "50042";
//     begin
//         rec50042.RESET;
//         rec50042.SETCURRENTKEY("Customer No.",Season);
//         rec50042.SETRANGE("Customer No.",Rec."Customer No.");
//         rec50042.SETRANGE(Season,Rec.Season);
//         IF rec50042.FINDFIRST THEN
//           ERROR('You have already generated Marketing Indent for Distributor %1 with Season %2.',Rec."Customer No.",Rec.Season);
//     end;
// }

