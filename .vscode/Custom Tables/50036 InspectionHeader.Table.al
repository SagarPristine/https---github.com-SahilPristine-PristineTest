table 50036 "Inspection Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


            trigger OnValidate()
            var
                recul: Record "User Location";
                recloc: Record Location;
                NoSeriesMgt: Codeunit NoSeriesManagement;

            begin
                IF "No." <> xRec."No." THEN BEGIN
                    IF Rec.Type = Rec.Type::Nursery THEN BEGIN
                        recUL.RESET;
                        recUL.SETCURRENTKEY("User ID");
                        recUL.SETRANGE("User ID", USERID);
                        recul.SetRange("Location Code", "Production Centre");
                        recUL.SETRANGE(Inspection, TRUE);
                        IF recUL.FINDFIRST THEN BEGIN
                            IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                recLoc.TESTFIELD("Nursery No. Series");
                                NoSeriesMgt.TestManual(recLoc."Nursery No. Series");
                                "No. Series" := '';
                            END ELSE
                                ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Nursery No. Series"));
                        END ELSE
                            ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                    END ELSE
                        IF Rec.Type = Rec.Type::Vegetative THEN BEGIN
                            recUL.RESET;
                            recUL.SETCURRENTKEY("User ID");
                            recUL.SETRANGE("User ID", USERID);
                            recUL.SETRANGE(Inspection, TRUE);
                            recul.SetRange("Location Code", "Production Centre");
                            IF recUL.FINDFIRST THEN BEGIN
                                IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                    recLoc.TESTFIELD("Vegetative No. Series");
                                    NoSeriesMgt.TestManual(recLoc."Vegetative No. Series");
                                    "No. Series" := '';
                                END ELSE
                                    ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Vegetative No. Series"));
                            END ELSE
                                ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                        END ELSE
                            IF Rec.Type = Rec.Type::Isolation THEN BEGIN
                                recUL.RESET;
                                recUL.SETCURRENTKEY("User ID");
                                recUL.SETRANGE("User ID", USERID);
                                recUL.SETRANGE(Inspection, TRUE);
                                recul.SetRange("Location Code", "Production Centre");
                                IF recUL.FINDFIRST THEN BEGIN
                                    IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                        recLoc.TESTFIELD("Isolation No. Series");
                                        NoSeriesMgt.TestManual(recLoc."Isolation No. Series");
                                        "No. Series" := '';
                                    END ELSE
                                        ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Isolation No. Series"));
                                END ELSE
                                    ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                            END ELSE
                                IF Rec.Type = Rec.Type::"Pre Flowering Roughing" THEN BEGIN
                                    recUL.RESET;
                                    recUL.SETCURRENTKEY("User ID");
                                    recUL.SETRANGE("User ID", USERID);
                                    recUL.SETRANGE(Inspection, TRUE);
                                    recul.SetRange("Location Code", "Production Centre");
                                    IF recUL.FINDFIRST THEN BEGIN
                                        IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                            recLoc.TESTFIELD("Pre Flowering Roug. No. Series");
                                            NoSeriesMgt.TestManual(recLoc."Pre Flowering Roug. No. Series");
                                            "No. Series" := '';
                                        END ELSE
                                            ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Pre Flowering Roug. No. Series"));
                                    END ELSE
                                        ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                                END ELSE
                                    IF Rec.Type = Rec.Type::"Flowering Roughing" THEN BEGIN
                                        recUL.RESET;
                                        recUL.SETCURRENTKEY("User ID");
                                        recUL.SETRANGE("User ID", USERID);
                                        recUL.SETRANGE(Inspection, TRUE);
                                        IF recUL.FINDFIRST THEN BEGIN
                                            IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                                recLoc.TESTFIELD("Flowering Roughing No. Series");
                                                NoSeriesMgt.TestManual(recLoc."Flowering Roughing No. Series");
                                                "No. Series" := '';
                                            END ELSE
                                                ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Flowering Roughing No. Series"));
                                        END ELSE
                                            ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                                    END ELSE
                                        IF Rec.Type = Rec.Type::MaleChoping THEN BEGIN
                                            recUL.RESET;
                                            recUL.SETCURRENTKEY("User ID");
                                            recUL.SETRANGE("User ID", USERID);
                                            recUL.SETRANGE(Inspection, TRUE);
                                            IF recUL.FINDFIRST THEN BEGIN
                                                IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                                    recLoc.TESTFIELD("MaleChoping No. Series");
                                                    NoSeriesMgt.TestManual(recLoc."MaleChoping No. Series");
                                                    "No. Series" := '';
                                                END ELSE
                                                    ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("MaleChoping No. Series"));
                                            END ELSE
                                                ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                                        END ELSE
                                            IF Rec.Type = Rec.Type::"Final Roughing" THEN BEGIN
                                                recUL.RESET;
                                                recUL.SETCURRENTKEY("User ID");
                                                recUL.SETRANGE("User ID", USERID);
                                                recUL.SETRANGE(recul.Inspection, TRUE);
                                                IF recUL.FINDFIRST THEN BEGIN
                                                    IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                                        recLoc.TESTFIELD("Final Roughing No. Series");
                                                        NoSeriesMgt.TestManual(recLoc."Final Roughing No. Series");
                                                        "No. Series" := '';
                                                    END ELSE
                                                        ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Final Roughing No. Series"));
                                                END ELSE
                                                    ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                                            END ELSE
                                                IF Rec.Type = Rec.Type::Harvesting THEN BEGIN
                                                    recUL.RESET;
                                                    recUL.SETCURRENTKEY("User ID");
                                                    recUL.SETRANGE("User ID", USERID);
                                                    recUL.SETRANGE(Inspection, TRUE);
                                                    IF recUL.FINDFIRST THEN BEGIN
                                                        IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                                            recLoc.TESTFIELD("Harvesting No. Series");
                                                            NoSeriesMgt.TestManual(recLoc."Harvesting No. Series");
                                                            "No. Series" := '';
                                                        END ELSE
                                                            ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Harvesting No. Series"));
                                                    END ELSE
                                                        ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                                                END else
                                                    IF Rec.Type = Rec.Type::Pollination THEN BEGIN
                                                        recUL.RESET;
                                                        recUL.SETCURRENTKEY("User ID");
                                                        recUL.SETRANGE("User ID", USERID);
                                                        recUL.SETRANGE(Inspection, TRUE);
                                                        IF recUL.FINDFIRST THEN BEGIN
                                                            IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                                                recLoc.TESTFIELD("Pollination No. Series");
                                                                NoSeriesMgt.TestManual(recLoc."Pollination No. Series");
                                                                "No. Series" := '';
                                                            END ELSE
                                                                ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Pollination No. Series"));
                                                        END ELSE
                                                            ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                                                    END else
                                                        IF Rec.Type = Rec.Type::"Vegetative Roughing" THEN BEGIN
                                                            recUL.RESET;
                                                            recUL.SETCURRENTKEY("User ID");
                                                            recUL.SETRANGE("User ID", USERID);
                                                            recUL.SETRANGE(Inspection, TRUE);
                                                            IF recUL.FINDFIRST THEN BEGIN
                                                                IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                                                    recLoc.TESTFIELD("Vegetative Roughing No. Series");
                                                                    NoSeriesMgt.TestManual(recLoc."Vegetative Roughing No. Series");
                                                                    "No. Series" := '';
                                                                END ELSE
                                                                    ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Vegetative Roughing No. Series"));
                                                            END ELSE
                                                                ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                                                        END;
                END;
            end;
        }
        field(2; Type; Enum "Inspection Types")
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(3; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(15; "Production Centre"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;

            trigger OnValidate()
            var
            begin
            end;
        }
        field(16; "Date of Inspection"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(22; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Production Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Planting List Line"."Production Lot No." WHERE(Posted = FILTER(false));

            trigger OnValidate()
            var
                recPlantingList: Record "Planting List Line";
                recIL: Record "Inspection Line";
                lineNo: Integer;
                InspectionLine: Record "Inspection Line";
                Item: Record 27;
                InspectionLn: Record "Inspection Line";
                Varieties: Record Varieties;
            begin
                IF Rec."Production Lot No." <> '' THEN BEGIN
                    recPlantingList.RESET;
                    recPlantingList.SETCURRENTKEY("Production Lot No.");
                    recPlantingList.SETRANGE("Production Lot No.", Rec."Production Lot No.");
                    IF recPlantingList.FINDFIRST THEN BEGIN
                        recIL.RESET;
                        recIL.SETCURRENTKEY(Type, "Production Lot No.");
                        recIL.SETRANGE(Type, Rec.Type);
                        recIL.SETRANGE("Production Lot No.", Rec."Production Lot No.");
                        IF recIL.FINDFIRST THEN
                            ERROR('Production Lot No. already selected.');

                        //for fetching last line no
                        recIL.RESET;
                        recIL.SETCURRENTKEY("Document No.");
                        recIL.SETRANGE("Document No.", Rec."No.");
                        IF recIL.FINDLAST THEN
                            lineNo := recIL."Line No." + 10000
                        ELSE
                            lineNo := 10000;

                        //for creating inspection line
                        recIL.RESET;
                        recIL.INIT;
                        recIL."Document No." := Rec."No.";
                        recIL."Line No." := lineNo;
                        recIL.Type := Rec.Type;
                        recIL."Item No." := recPlantingList."Item No.";
                        recIL."Variety Code" := recPlantingList."Variety Code";
                        recIL.VALIDATE("Production Lot No.", Rec."Production Lot No.");
                        recIL."Grower Owner" := recPlantingList."Grower Owner";
                        recIL."Grower/Land Owner Name" := recPlantingList."Grower/Land Owner Name";
                        recIL."Crop Code" := recPlantingList."Crop Code";
                        recIL.Insert();
                        case Rec.Type OF
                            rec.Type::Vegetative:
                                begin

                                end;
                            rec.Type::Isolation:
                                begin

                                end;
                            rec.Type::"Vegetative Roughing":
                                begin
                                    InspectionLn.Reset();
                                    InspectionLn.SetRange(Type, InspectionLn.Type::Vegetative);
                                    InspectionLn.SetRange("Production Lot No.", Rec."Production Lot No.");
                                    InspectionLn.FindFirst();
                                    InspectionLn.TestField("Date of Transplanting");
                                    recIL."Planned Date" := InspectionLn."Date of Transplanting" + 25;
                                end;
                            rec.Type::"Pre Flowering Roughing":
                                begin
                                    InspectionLn.Reset();
                                    InspectionLn.SetRange(Type, InspectionLn.Type::Nursery);
                                    InspectionLn.SetRange("Production Lot No.", Rec."Production Lot No.");
                                    InspectionLn.FindFirst();
                                    InspectionLn.TestField(InspectionLn."Date of Sowing");
                                    Varieties.Reset();
                                    Varieties.Get(InspectionLn."Variety Code");
                                    recIL."Planned Date" := (InspectionLn."Date of Sowing" + Varieties.Duration) - 45;
                                end;
                            rec.Type::"Flowering Roughing":
                                begin
                                    InspectionLn.Reset();
                                    InspectionLn.SetRange(Type, InspectionLn.Type::Nursery);
                                    InspectionLn.SetRange("Production Lot No.", Rec."Production Lot No.");
                                    InspectionLn.FindFirst();
                                    InspectionLn.TestField(InspectionLn."Date of Sowing");
                                    Varieties.Reset();
                                    Varieties.Get(InspectionLn."Variety Code");
                                    recIL."Planned Date" := (InspectionLn."Date of Sowing" + Varieties.Duration) - 35;
                                end;
                            rec.Type::Pollination:
                                begin

                                end;
                            rec.Type::MaleChoping:
                                begin
                                    InspectionLn.Reset();
                                    InspectionLn.SetRange(Type, InspectionLn.Type::Nursery);
                                    InspectionLn.SetRange("Production Lot No.", Rec."Production Lot No.");
                                    InspectionLn.FindFirst();
                                    InspectionLn.TestField(InspectionLn."Date of Sowing");
                                    Varieties.Reset();
                                    Varieties.Get(InspectionLn."Variety Code");
                                    recIL."Target Date" := (InspectionLn."Date of Sowing" + Varieties.Duration) - 7;
                                end;
                            rec.Type::"Final Roughing":
                                begin
                                    InspectionLn.Reset();
                                    InspectionLn.SetRange(Type, InspectionLn.Type::Nursery);
                                    InspectionLn.SetRange("Production Lot No.", Rec."Production Lot No.");
                                    InspectionLn.FindFirst();
                                    InspectionLn.TestField(InspectionLn."Date of Sowing");
                                    Varieties.Reset();
                                    Varieties.Get(InspectionLn."Variety Code");
                                    recIL."Planned Date" := (InspectionLn."Date of Sowing" + Varieties.Duration) - 5;
                                end;
                            rec.Type::Harvesting:
                                begin

                                end;
                        end;
                        recIL.Modify();
                    END;
                end;
            end;
        }
        field(25; "App Inspection"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        recul: Record "User Location";
        RecLoc: Record Location;
    begin
        IF "No." = '' THEN BEGIN
            IF Rec.Type = Rec.Type::Nursery THEN BEGIN
                recUL.RESET;
                recUL.SETCURRENTKEY("User ID");
                recUL.SETRANGE("User ID", USERID);
                recUL.SETRANGE(inspection, TRUE);
                IF recUL.FINDFIRST THEN BEGIN
                    IF recLoc.GET(recUL."Location Code") THEN BEGIN
                        recLoc.TESTFIELD("Nursery No. Series");
                        NoSeriesMgt.InitSeries(recLoc."Nursery No. Series", xRec."No. Series", 0D, "No.", "No. Series");
                    END ELSE
                        ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Nursery No. Series"));
                END ELSE
                    ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
            END ELSE
                IF Rec.Type = Rec.Type::Vegetative THEN BEGIN
                    recUL.RESET;
                    recUL.SETCURRENTKEY("User ID");
                    recUL.SETRANGE("User ID", USERID);
                    recUL.SETRANGE(inspection, TRUE);
                    IF recUL.FINDFIRST THEN BEGIN
                        IF recLoc.GET(recUL."Location Code") THEN BEGIN
                            recLoc.TESTFIELD("Vegetative No. Series");
                            NoSeriesMgt.InitSeries(recLoc."Vegetative No. Series", xRec."No. Series", 0D, "No.", "No. Series");
                        END ELSE
                            ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Vegetative No. Series"));
                    END ELSE
                        ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                END ELSE
                    IF Rec.Type = Rec.Type::Isolation THEN BEGIN
                        recUL.RESET;
                        recUL.SETCURRENTKEY("User ID");
                        recUL.SETRANGE("User ID", USERID);
                        recUL.SETRANGE(inspection, TRUE);
                        IF recUL.FINDFIRST THEN BEGIN
                            IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                recLoc.TESTFIELD("Isolation No. Series");
                                NoSeriesMgt.InitSeries(recLoc."Isolation No. Series", xRec."No. Series", 0D, "No.", "No. Series");
                            END ELSE
                                ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Isolation No. Series"));
                        END ELSE
                            ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                    END ELSE
                        IF Rec.Type = Rec.Type::"Pre Flowering Roughing" THEN BEGIN
                            recUL.RESET;
                            recUL.SETCURRENTKEY("User ID");
                            recUL.SETRANGE("User ID", USERID);
                            recUL.SETRANGE(inspection, TRUE);
                            IF recUL.FINDFIRST THEN BEGIN
                                IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                    recLoc.TESTFIELD("Pre Flowering Roug. No. Series");
                                    NoSeriesMgt.InitSeries(recLoc."Pre Flowering Roug. No. Series", xRec."No. Series", 0D, "No.", "No. Series");
                                END ELSE
                                    ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Pre Flowering Roug. No. Series"));
                            END ELSE
                                ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                        END ELSE
                            IF Rec.Type = Rec.Type::"Flowering Roughing" THEN BEGIN
                                recUL.RESET;
                                recUL.SETCURRENTKEY("User ID");
                                recUL.SETRANGE("User ID", USERID);
                                recUL.SETRANGE(inspection, TRUE);
                                IF recUL.FINDFIRST THEN BEGIN
                                    IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                        recLoc.TESTFIELD("Flowering Roughing No. Series");
                                        NoSeriesMgt.InitSeries(recLoc."Flowering Roughing No. Series", xRec."No. Series", 0D, "No.", "No. Series");
                                    END ELSE
                                        ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Flowering Roughing No. Series"));
                                END ELSE
                                    ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                            END ELSE
                                IF Rec.Type = Rec.Type::MaleChoping THEN BEGIN
                                    recUL.RESET;
                                    recUL.SETCURRENTKEY("User ID");
                                    recUL.SETRANGE("User ID", USERID);
                                    recUL.SETRANGE(inspection, TRUE);
                                    IF recUL.FINDFIRST THEN BEGIN
                                        IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                            recLoc.TESTFIELD("MaleChoping No. Series");
                                            NoSeriesMgt.InitSeries(recLoc."MaleChoping No. Series", xRec."No. Series", 0D, "No.", "No. Series");
                                        END ELSE
                                            ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("MaleChoping No. Series"));
                                    END ELSE
                                        ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                                END ELSE
                                    IF Rec.Type = Rec.Type::"Final Roughing" THEN BEGIN
                                        recUL.RESET;
                                        recUL.SETCURRENTKEY("User ID");
                                        recUL.SETRANGE("User ID", USERID);
                                        recUL.SETRANGE(inspection, TRUE);
                                        IF recUL.FINDFIRST THEN BEGIN
                                            IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                                recLoc.TESTFIELD("Final Roughing No. Series");
                                                NoSeriesMgt.InitSeries(recLoc."Final Roughing No. Series", xRec."No. Series", 0D, "No.", "No. Series");
                                            END ELSE
                                                ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Final Roughing No. Series"));
                                        END ELSE
                                            ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                                    END ELSE
                                        IF Rec.Type = Rec.Type::Harvesting THEN BEGIN
                                            recUL.RESET;
                                            recUL.SETCURRENTKEY("User ID");
                                            recUL.SETRANGE("User ID", USERID);
                                            recUL.SETRANGE(inspection, TRUE);
                                            IF recUL.FINDFIRST THEN BEGIN
                                                IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                                    recLoc.TESTFIELD("Harvesting No. Series");
                                                    NoSeriesMgt.InitSeries(recLoc."Harvesting No. Series", xRec."No. Series", 0D, "No.", "No. Series");
                                                END ELSE
                                                    ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Harvesting No. Series"));
                                            END ELSE
                                                ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                                        END ELSE
                                            IF Rec.Type = Rec.Type::"Vegetative Roughing" THEN BEGIN
                                                recUL.RESET;
                                                recUL.SETCURRENTKEY("User ID");
                                                recUL.SETRANGE("User ID", USERID);
                                                recUL.SETRANGE(inspection, TRUE);
                                                IF recUL.FINDFIRST THEN BEGIN
                                                    IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                                        recLoc.TESTFIELD("Vegetative Roughing No. Series");
                                                        NoSeriesMgt.InitSeries(recLoc."Vegetative Roughing No. Series", xRec."No. Series", 0D, "No.", "No. Series");
                                                    END ELSE
                                                        ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Vegetative Roughing No. Series"));
                                                END ELSE
                                                    ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                                            END ELSE
                                                IF Rec.Type = Rec.Type::Pollination THEN BEGIN
                                                    recUL.RESET;
                                                    recUL.SETCURRENTKEY("User ID");
                                                    recUL.SETRANGE("User ID", USERID);
                                                    recUL.SETRANGE(inspection, TRUE);
                                                    IF recUL.FINDFIRST THEN BEGIN
                                                        IF recLoc.GET(recUL."Location Code") THEN BEGIN
                                                            recLoc.TESTFIELD("Pollination No. Series");
                                                            NoSeriesMgt.InitSeries(recLoc."Pollination No. Series", xRec."No. Series", 0D, "No.", "No. Series");
                                                        END ELSE
                                                            ERROR('Location Code %1 %2 ''. It cannot be Blank.', recUL."Location Code", recLoc.FIELDCAPTION("Pollination No. Series"));
                                                    END ELSE
                                                        ERROR('User doesnot have permission to Create Record. Please contact your System Administrator.');
                                                END
        END;
    end;

    var
        NoSeriesMgt: Codeunit 396;
        recUL: Record "User Location";
        recCI: Record 79;
        recLoc: Record 14;
        InvtrySetup: Record 313;
}

