page 50078 "Inspection Subform 2"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Inspection Line";
    SourceTableView = WHERE(Type = FILTER(Vegetative));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Previous Crop: Main Field"; Rec."Previous Crop: Main Field")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Previous Crop: Main Field field.';
                }
                field("Previous Crop Nursery"; Rec."Previous Crop Nursery")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Previous Crop Nursery field.';
                }
                field("Seedling Age of Female"; Rec."Seedling Age of Female")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seedling Age of Female field.';
                    Editable = false;
                    trigger OnValidate()
                    var
                        InspectionLn: Record "Inspection Line";
                    begin
                        InspectionLn.Reset();
                        InspectionLn.SetRange(Type, InspectionLn.Type::Nursery);
                        InspectionLn.SetRange("Production Lot No.", Rec."Production Lot No.");
                        InspectionLn.FindFirst();
                        rec.TestField("Date of Transplanting");
                        Rec."Seedling Age of Female" := rec."Date of Transplanting" - InspectionLn."Date of Sowing";
                    end;
                }
                field("Net Standing Area (in Acres)"; Rec."Net Standing Area (in Acres)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Standing Area (in Acres) field.';
                }

                field("Production Lot No."; rec."Production Lot No.")
                {
                    ApplicationArea = all;
                }
                field("Organizer/Co-ordinator Name"; rec."Organizer Code")
                {
                    ApplicationArea = all;
                    Caption = 'Organizer/Co-ordinator Name';
                }
                field("Grower/Land Owner Name"; rec."Grower/Land Owner Name")
                {
                    ApplicationArea = all;
                }
                field("Grower Village"; rec."Grower Village")
                {
                    ApplicationArea = all;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = all;
                }
                field("Crop Code"; rec."Crop Code")
                {
                    ApplicationArea = all;
                }
                field("Item Class of Seeds"; rec."Item Class of Seeds")
                {
                    ApplicationArea = all;
                }
                field("Item Crop Type"; rec."Item Crop Type")
                {
                    ApplicationArea = all;
                }
                field("Date of Transplanting"; Rec."Date of Transplanting")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Transplanting field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Date of visit"; Rec."Date of visit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of visit field.';
                }
                field("Soil Type"; Rec."Soil Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Soil Type field.';
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin

    end;

    trigger OnAfterGetRecord()
    begin

    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveSalesLine: Codeunit 99000832;
    begin

    end;

    var

}

