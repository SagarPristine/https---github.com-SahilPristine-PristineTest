#pragma warning disable
page 50052 "ILE List For Process Transfer"
{
    Caption = 'Item Ledger Entries';
    DataCaptionExpression = GetCaption;
    DataCaptionFields = "Item No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 32;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = all;
                }
                field("Crop Code"; "Crop Code")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = all;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = all;
                }
                field("Variant Code"; "Variant Code")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; "Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = all;
                }
                field("No. of Bags/Pckt"; "No. of Bags/Pckt")
                {
                    ApplicationArea = all;
                }
                field("Remaining Quantity"; "Remaining Quantity")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Item.GET("Item No.");
        IF Item."FG Pack Size" > 0 THEN
            RemNoofbags := "Remaining Quantity" / Item."FG Pack Size";
        IF Tobeexecutervc2 = TRUE THEN
            Visib := FALSE
        ELSE
            Visib := TRUE;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        // IF (CloseAction = ACTION::LookupOK) AND (Tobeexecutervc2 = TRUE) THEN
        //     InsertVCEntry();
        // IF (CloseAction = ACTION::LookupOK) AND (TobeexecuteBlend2 = TRUE) THEN
        //     InsertblendingEntry;
    end;

    var
        Navigate: Page 344;
        RemNoofbags: Decimal;
        Item: Record 27;
        "Qty to be taken": Decimal;
        "Complete pckt": Boolean;
        Tobeexecutervc2: Boolean;
        RetestNo2: Code[20];
        LineNo: Integer;
        Visib: Boolean;
        blendno2: Code[20];
        TobeexecuteBlend2: Boolean;

    local procedure GetCaption(): Text
    var
        GLSetup: Record 98;
        ObjTransl: Record 377;
        Item: Record 27;
        ProdOrder: Record 5405;
        Cust: Record 18;
        Vend: Record 23;
        Dimension: Record 348;
        DimValue: Record 349;
        SourceTableName: Text;
        SourceFilter: Text[200];
        Description: Text[100];
    begin
        Description := '';

        CASE TRUE OF
            GETFILTER("Item No.") <> '':
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 27);
                    SourceFilter := GETFILTER("Item No.");
                    IF MAXSTRLEN(Item."No.") >= STRLEN(SourceFilter) THEN
                        IF Item.GET(SourceFilter) THEN
                            Description := Item.Description;
                END;
            (GETFILTER("Order No.") <> '') AND ("Order Type" = "Order Type"::Production):
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 5405);
                    SourceFilter := GETFILTER("Order No.");
                    IF MAXSTRLEN(ProdOrder."No.") >= STRLEN(SourceFilter) THEN
                        IF ProdOrder.GET(ProdOrder.Status::Released, SourceFilter) OR
                           ProdOrder.GET(ProdOrder.Status::Finished, SourceFilter)
                        THEN BEGIN
                            SourceTableName := STRSUBSTNO('%1 %2', ProdOrder.Status, SourceTableName);
                            Description := ProdOrder.Description;
                        END;
                END;
            GETFILTER("Source No.") <> '':
                CASE "Source Type" OF
                    "Source Type"::Customer:
                        BEGIN
                            SourceTableName :=
                              ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 18);
                            SourceFilter := GETFILTER("Source No.");
                            IF MAXSTRLEN(Cust."No.") >= STRLEN(SourceFilter) THEN
                                IF Cust.GET(SourceFilter) THEN
                                    Description := Cust.Name;
                        END;
                    "Source Type"::Vendor:
                        BEGIN
                            SourceTableName :=
                              ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 23);
                            SourceFilter := GETFILTER("Source No.");
                            IF MAXSTRLEN(Vend."No.") >= STRLEN(SourceFilter) THEN
                                IF Vend.GET(SourceFilter) THEN
                                    Description := Vend.Name;
                        END;
                END;
            GETFILTER("Global Dimension 1 Code") <> '':
                BEGIN
                    GLSetup.GET;
                    Dimension.Code := GLSetup."Global Dimension 1 Code";
                    SourceFilter := GETFILTER("Global Dimension 1 Code");
                    SourceTableName := Dimension.GetMLName(GLOBALLANGUAGE);
                    IF MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) THEN
                        IF DimValue.GET(GLSetup."Global Dimension 1 Code", SourceFilter) THEN
                            Description := DimValue.Name;
                END;
            GETFILTER("Global Dimension 2 Code") <> '':
                BEGIN
                    GLSetup.GET;
                    Dimension.Code := GLSetup."Global Dimension 2 Code";
                    SourceFilter := GETFILTER("Global Dimension 2 Code");
                    SourceTableName := Dimension.GetMLName(GLOBALLANGUAGE);
                    IF MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) THEN
                        IF DimValue.GET(GLSetup."Global Dimension 2 Code", SourceFilter) THEN
                            Description := DimValue.Name;
                END;
            GETFILTER("Document Type") <> '':
                BEGIN
                    SourceTableName := GETFILTER("Document Type");
                    SourceFilter := GETFILTER("Document No.");
                    Description := GETFILTER("Document Line No.");
                END;
        END;
        EXIT(STRSUBSTNO('%1 %2 %3', SourceTableName, SourceFilter, Description));
    end;

    // procedure Toberun(TobeexecuteRVD: Boolean; RetestNo: Code[20])
    // begin
    //     Tobeexecutervc2 := TobeexecuteRVD;
    //     RetestNo2 := RetestNo;
    // end;

    // [Scope('Internal')]
    // procedure InsertVCEntry()
    // var
    //     VCLine2: Record "50122";
    //     CropStageMaster: Record "50001";
    //     VCLine: Record "50122";
    // begin
    //     CurrPage.SETSELECTIONFILTER(Rec);
    //     IF FINDSET THEN BEGIN
    //         REPEAT
    //             VCLine2.RESET;
    //             VCLine2.SETRANGE("VC No.", RetestNo2);
    //             IF NOT VCLine2.FINDLAST THEN
    //                 LineNo := 10000
    //             ELSE
    //                 LineNo := VCLine2."VC Line No." + 10000;
    //             VCLine.INIT;
    //             VCLine."VC No." := RetestNo2;
    //             VCLine."VC Line No." := LineNo;
    //             VCLine."Current Lot No." := Rec."Lot No.";
    //             VCLine."New Lot No." := Rec."Lot No.";
    //             VCLine."Quantity (in Kgs)" := Rec."Remaining Quantity";
    //             VCLine."No. of bags" := Rec."No. of Bags/Pckt";
    //             VCLine.INSERT;
    //         UNTIL Rec.NEXT = 0;
    //     END;
    // end;

    procedure ToberunforBlending(TobeexecuteBlend: Boolean; blendno: Code[20])
    begin
        TobeexecuteBlend2 := TobeexecuteBlend;
        blendno2 := blendno;
    end;

    procedure GetSelectionFilter(): Text
    var
        myInt: Integer;
        ILe: Record "Item Ledger Entry";
        Codeunit50002: Codeunit 50002;
    begin
        CurrPage.SETSELECTIONFILTER(ILe);
        EXIT(Codeunit50002.GetSelectedLotDetails(ILe));
    end;



    // procedure InsertblendingEntry()
    // var
    //     VCLine2: Record 50122;
    //     CropStageMaster: Record 50001;
    //     VCLine: Record 50122;
    //     BlendLines: Record 50026;
    //     recWM: Record 7312;
    // begin
    //     CurrPage.SETSELECTIONFILTER(Rec);
    //     IF FINDSET THEN BEGIN
    //         REPEAT
    //             CLEAR(LineNo);

    //             BlendLines.RESET;
    //             BlendLines.SETCURRENTKEY("Blend No.", "Line No.");
    //             BlendLines.SETRANGE("Blend No.", blendno2);
    //             IF BlendLines.FINDLAST THEN
    //                 LineNo := BlendLines."Line No." + 10000
    //             ELSE
    //                 LineNo := BlendLines."Line No." + 10000;

    //             BlendLines.RESET;
    //             BlendLines.INIT;
    //             BlendLines."Blend No." := blendno2;
    //             BlendLines."Bute No." := "Lot No.";
    //             BlendLines."Line No." := LineNo;
    //             //old savanaah BlendLines."Receipt No.":=itemledgerentry3."Receipt No.";
    //             BlendLines."Location Code" := "Location Code";
    //             BlendLines."Item No." := "Item No.";
    //             BlendLines."Crop Code" := "Crop Code";
    //             BlendLines."Stage Code" := "Variant Code";
    //             BlendLines."Entry No." := "Entry No.";
    //             BlendLines."No. Of Bags" := "No. of Bags/Pckt"; //PBS MAN 160314
    //             BlendLines."Season Code" := "Season Code";

    //             recWM.RESET;
    //             recWM.SETCURRENTKEY("Lot No.", "Location Code");
    //             recWM.SETRANGE("Location Code", "Location Code");
    //             recWM.SETRANGE("Lot No.", "Lot No.");
    //             IF recWM.FINDLAST THEN
    //                 BlendLines."Bin Code" := recWM."Bin Code"
    //             ELSE
    //                 ERROR('Enable to fetch details of Bin/Stack Code.');
    //             BlendLines.INSERT(TRUE);
    //             BlendLines.VALIDATE("Item No.", "Item No.");
    //             BlendLines.VALIDATE("Unit of Measure Code", "Unit of Measure Code");
    //             BlendLines.VALIDATE("Qty (Base)", "Remaining Quantity");
    //             Item.GET("Item No.");
    //             Item.TESTFIELD(Blocked, FALSE);
    //             BlendLines.Description := Description;
    //             BlendLines.MODIFY;
    //         UNTIL Rec.NEXT = 0;
    //     END;
    // end;
}


