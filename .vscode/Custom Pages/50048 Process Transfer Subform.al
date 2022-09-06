#pragma warning disable
page 50048 "Process Transfer Subform"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Process Line";
    SourceTableView = WHERE("Entry Type" = FILTER(Output));

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Document No."; "Document No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Line No."; "Line No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Entry Type"; "Entry Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bom No"; "Bom No")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("From Bute No."; "From Bute No.")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        rec32: Record 32;
                        rec50007: Record "Process Header";
                        rec27: Record 27;
                        Recitem: Record 27;
                        ItemLedgerEntry: Record "Item Ledger Entry";
                        ItemLedgerEntries: Page "Item Ledger Entries";
                        SelectFilter: Text;
                        ILEPage: Page 50052;
                        OldLot: Code[20];
                    begin

                        rec50007.RESET;
                        IF rec50007.GET(Rec."Document No.") THEN BEGIN
                            "Crop Code" := rec50007."Crop Code";
                            rec32.RESET;
                            rec32.SETCURRENTKEY("Item No.", "Crop Code", "Variant Code", "Lot No.", "Entry Type", "Location Code");
                            rec32.SETRANGE("Item No.", rec50007."Item No.");
                            rec32.SETRANGE("Crop Code", rec50007."Crop Code");
                            rec32.SETRANGE("Variant Code", rec50007."From Stage");
                            rec32.SETFILTER("Entry Type", '%1|%2|%3', rec32."Entry Type"::"Positive Adjmt.", rec32."Entry Type"::Purchase, rec32."Entry Type"::Transfer);
                            rec32.SETFILTER("Remaining Quantity", '>0');
                            rec32.SETRANGE("Location Code", rec50007.Location);
                            ILEPage.LookupMode(true);
                            ILEPage.SetTableView(rec32);
                            if ILEPage.RunModal() = action::LookupOK then
                                SelectFilter := ILEPage.GetSelectionFilter;

                            if SelectFilter <> '' then begin
                                rec32.Reset();
                                rec32.SetCurrentKey("Lot No.");
                                rec32.SetFilter("Entry No.", SelectFilter);
                                if rec32.FindSet() then begin
                                    Rec."No. of Bags/Pckt" := 0;
                                    Rec."Total Avai. Qty." := 0;
                                    Rec."Required Bags" := 0;
                                    Rec."Required Qty." := 0;
                                    repeat
                                        if (OldLot = rec32."Lot No.") Or (OldLot = '') then begin
                                            Rec."No. of Bags/Pckt" += rec32."No. of Bags/Pckt";
                                            Rec."Total Avai. Qty." += rec32."Remaining Quantity";
                                            Rec."Required Bags" += rec32."No. of Bags/Pckt";
                                            Rec."Required Qty." += rec32."Remaining Quantity";
                                            OldLot := rec32."Lot No.";
                                        end else
                                            Error('You cannot select different lot in one go!');
                                    until rec32.Next() = 0;
                                    rec.Validate("From Bute No.", rec32."Lot No.");
                                end;
                            end;
                            CurrPage.Update(true);
                        end;
                    END;
                    //END;

                    trigger OnValidate()
                    var
                        rec32: Record 32;
                        rec50007: Record "Process Header";
                        rec27: Record 27;
                    begin
                        IF Rec."From Bute No." <> '' THEN BEGIN
                            rec50007.RESET;
                            IF rec50007.GET(Rec."Document No.") THEN BEGIN
                                rec32.RESET;
                                rec32.SETCURRENTKEY("Item No.", "Crop Code", "Variant Code", "Lot No.", "Entry Type", "Location Code");
                                rec32.SETRANGE("Item No.", rec50007."Item No.");
                                rec32.SETRANGE("Crop Code", rec50007."Crop Code");
                                rec32.SETRANGE("Variant Code", rec50007."From Stage");
                                rec32.SETFILTER("Entry Type", '%1|%2|%3', rec32."Entry Type"::"Positive Adjmt.", rec32."Entry Type"::Purchase, rec32."Entry Type"::Transfer);
                                rec32.SETFILTER("Remaining Quantity", '>0');
                                rec32.SETRANGE("Location Code", rec50007.Location);
                                rec32.SETRANGE("Lot No.", Rec."From Bute No.");
                                IF rec32.FINDFIRST THEN BEGIN
                                    Rec.VALIDATE("ILE Document No.", rec32."Document No.");
                                    Rec.VALIDATE("From Bute No.", rec32."Lot No.");
                                    IF Rec."From Stage" = 'CONDITIONED' THEN BEGIN
                                        rec27.RESET;
                                        IF NOT rec27.GET(rec50007."Item No.") THEN
                                            ERROR('Unable to fetch details of Item No. %1', rec50007."Item No.");
                                        // IF rec32.RVD = FALSE THEN
                                        //     Rec.VALIDATE("Packed Item Code", rec27."Marketing Code");
                                        IF rec32.RVD = TRUE THEN
                                            Rec.VALIDATE("Packed Item Code", rec50007."Item No.");
                                    END;
                                    Rec.MODIFY;
                                END;
                            END;
                        END;
                    end;
                }
                field("From Bin/Stack Code"; "From Bin/Stack Code")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        BinContent: Record "Bin Content";
                    begin
                        TestField("From Bute No.");
                        TestField("Location Code");
                        BinContent.RESET;
                        BinContent.SetCurrentKey(BinContent."Item No.", BinContent."Location Code");
                        BinContent.SetRange("Location Code", "Location Code");
                        BinContent.SetRange("Lot No. Filter", Rec."From Bute No.");
                        BinContent.SetFilter(Quantity, '>%1', 0);
                        IF PAGE.RUNMODAL(7304, BinContent) = ACTION::LookupOK THEN BEGIN
                            "To Location Code" := BinContent."Location Code";
                            "From Bin/Stack Code" := BinContent."Bin Code";
                            "To Bin/Stack Code" := BinContent."Bin Code";
                            "Remenant Bin/Stack Code" := BinContent."Bin Code";
                            "Lint Bin/Stack Code" := BinContent."Bin Code";
                            CurrPage.Update();
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        if "From Bin/Stack Code" = '' then begin
                            "To Bin/Stack Code" := '';
                            "To Location Code" := '';
                        end;

                    end;
                }
                field("No. of Bags/Pckt"; "No. of Bags/Pckt")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Total Avai. Qty."; "Total Avai. Qty.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'It shows the total Inventory for the selected Lot.!';
                }
                field("Required Bags"; "Required Bags")
                {
                    ApplicationArea = all;
                    ToolTip = 'If you want to process the partial Bags then you can update the required bags here!';
                }
                field("Required Qty."; "Required Qty.")
                {
                    ApplicationArea = all;
                    ToolTip = 'If you want to process the partiall Qty then you can update the required qty here!';
                }
                field("Good No. of Bags/Pckt"; "Good No. of Bags/Pckt")
                {
                    ApplicationArea = all;
                }
                field("Good Qty."; "Good Qty.")
                {
                    ApplicationArea = all;
                }
                field("Remenant No. of Bags/Pckt"; "Remenant No. of Bags/Pckt")
                {
                    ApplicationArea = all;
                }
                field("Remenant Qty."; "Remenant Qty.")
                {
                    ApplicationArea = all;
                }
                field("Remenant Bin/Stack Code"; "Remenant Bin/Stack Code")
                {
                    ApplicationArea = all;
                    // LookupPageID = "IBC List For Process Transfer";
                    TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));
                }

                field("Process Loss Qty."; "Process Loss Qty.")
                {
                    ApplicationArea = all;
                }
                field("Lint No. of Bags/Pckt"; Rec."Lint No. of Bags/Pckt")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lint No. of Bags/Pckt field.';
                }
                field("Lint Qty."; Rec."Lint Qty.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lint Qty. field.';

                }
                field("Lint Bin/Stack Code"; Rec."Lint Bin/Stack Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lint Bin/Stack Code field.';
                }
                field("To Bin/Stack Code"; "To Bin/Stack Code")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = all;
                }

                field("Location Code"; "Location Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Packed Item Code"; "Packed Item Code")
                {
                    ApplicationArea = all;
                    Enabled = "To Stage" = 'PACKED';
                }
                field("Marketing Lot No."; "Marketing Lot No.")
                {
                    ApplicationArea = all;
                    Enabled = "To Stage" = 'PACKED';
                }
                field("Packing By"; "Packing By")
                {
                    ApplicationArea = all;
                    Enabled = "To Stage" = 'PACKED';
                }
                field("Quality Test Date"; "Quality Test Date")
                {
                    ApplicationArea = all;
                    Enabled = "To Stage" = 'PACKED';
                }
                field("Expiry Date"; "Expiry Date")
                {
                    ApplicationArea = all;
                    Enabled = "To Stage" = 'PACKED';
                }
                field("To Stage"; "To Stage")
                {
                    ApplicationArea = all;

                    Visible = false;
                }
                field("To Location Code"; "To Location Code")
                {
                    ApplicationArea = all;

                }
                field("To Location Name"; "To Location Name")
                {
                    ApplicationArea = all;

                }
                field("Crop Code"; Rec."Crop Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Crop Code field.';
                    Visible = false;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
        }
    }

    trigger OnAfterGetRecord()
    begin
        ShowPackingDetailsItem := FALSE;
        ShowPackingDetailsQty := FALSE;
        ShowPackingDetailsGoodQty := TRUE;
        EditableQuality := FALSE;
        rec50007.RESET;
        IF rec50007.GET(Rec."Document No.") THEN BEGIN
            IF rec50007."To Stage" = 'PACKING' THEN BEGIN
                rec27.RESET;
                IF rec27.GET(Rec."Item No.") THEN
                    IF rec27."Class of Seeds" = rec27."Class of Seeds"::Breeder THEN BEGIN
                        ShowPackingDetailsGoodQty := FALSE;
                        ShowPackingDetailsItem := TRUE;
                        EditableQuality := FALSE;
                        //ShowPackingDetailsQty := TRUE;
                    END ELSE
                        IF rec27."Class of Seeds" = rec27."Class of Seeds"::Foundation THEN BEGIN
                            ShowPackingDetailsGoodQty := FALSE;
                            ShowPackingDetailsItem := TRUE;
                            EditableQuality := FALSE;
                            IF Rec.RVD = TRUE THEN
                                ShowPackingDetailsQty := TRUE;
                        END ELSE
                            IF rec27."Class of Seeds" = rec27."Class of Seeds"::TL THEN BEGIN
                                ShowPackingDetailsGoodQty := FALSE;
                                ShowPackingDetailsItem := TRUE;
                                ShowPackingDetailsQty := TRUE;
                                EditableQuality := FALSE;
                            END;
            END;
        END;

        EditableLint := FALSE;
        EditableRemenant := FALSE;
        Rec.CALCFIELDS("To Stage");
        IF Rec."To Stage" = 'GIN' THEN
            EditableLint := TRUE
        ELSE
            EditableRemenant := TRUE;

        IF Rec.RVD = TRUE THEN
            EditableQuality := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Entry Type" := "Entry Type"::Output;
    end;

    trigger OnOpenPage()
    begin
        ShowPackingDetailsItem := FALSE;
        ShowPackingDetailsQty := FALSE;
        ShowPackingDetailsGoodQty := TRUE;
        EditableQuality := FALSE;
        rec50007.RESET;
        IF rec50007.GET(Rec."Document No.") THEN BEGIN
            IF rec50007."To Stage" = 'PACKING' THEN BEGIN
                rec27.RESET;
                IF rec27.GET(Rec."Item No.") THEN
                    IF rec27."Class of Seeds" = rec27."Class of Seeds"::Breeder THEN BEGIN
                        ShowPackingDetailsGoodQty := FALSE;
                        ShowPackingDetailsItem := TRUE;
                        EditableQuality := FALSE;
                        //ShowPackingDetailsQty := TRUE;
                    END ELSE
                        IF rec27."Class of Seeds" = rec27."Class of Seeds"::Foundation THEN BEGIN
                            ShowPackingDetailsGoodQty := FALSE;
                            ShowPackingDetailsItem := TRUE;
                            EditableQuality := FALSE;
                            IF Rec.RVD = TRUE THEN
                                ShowPackingDetailsQty := TRUE;
                        END ELSE
                            IF rec27."Class of Seeds" = rec27."Class of Seeds"::TL THEN BEGIN
                                ShowPackingDetailsGoodQty := FALSE;
                                ShowPackingDetailsItem := TRUE;
                                ShowPackingDetailsQty := TRUE;
                                EditableQuality := FALSE;
                            END;
            END;
        END;

        EditableLint := FALSE;
        EditableRemenant := FALSE;
        Rec.CALCFIELDS("To Stage");
        IF Rec."To Stage" = 'GIN' THEN
            EditableLint := TRUE
        ELSE
            EditableRemenant := TRUE;

        IF Rec.RVD = TRUE THEN
            EditableQuality := TRUE;
    end;

    var
        ShowPackingDetailsGoodQty: Boolean;
        ShowPackingDetailsItem: Boolean;
        ShowPackingDetailsQty: Boolean;
        ReferenceNo: Text;
        RegisteringDate: Date;
        VariantCode: Text;
        rec7302: Record 7302;
        rec50007: Record "Process Header";
        EditableQuality: Boolean;
        rec27: Record 27;
        EditableLint: Boolean;
        EditableRemenant: Boolean;

}

