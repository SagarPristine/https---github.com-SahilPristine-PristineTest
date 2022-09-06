page 50083 "Inspection Subform 6"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Inspection Line";
    SourceTableView = WHERE(Type = FILTER(MaleChoping));

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Production Lot No."; rec."Production Lot No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Organizer/Co-ordinator Name"; rec."Organizer Code")
                {
                    ApplicationArea = all;
                    Caption = 'Organizer/Co-ordinator Name';
                    Editable = false;
                }
                field("Grower/Land Owner Name"; rec."Grower/Land Owner Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Grower Village"; rec."Grower Village")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Crop Code"; rec."Crop Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item Class of Seeds"; rec."Item Class of Seeds")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item Crop Type"; rec."Item Crop Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Target Date"; Rec."Target Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target Date field.';
                    Editable =false;
                }
                field("Actual Date"; Rec."Actual Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual Date field.';
                    trigger OnValidate()
                    begin
                        rec.Deviation := rec."Actual Date" - rec."Target Date";
                    end;
                }
                field(Deviation; Rec.Deviation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deviation field.';
                    Editable = false;
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

    trigger OnDeleteRecord(): Boolean
    var
    begin
    end;

    var

}

