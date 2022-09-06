page 50084 "Inspection Subform 7"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Inspection Line";
    SourceTableView = WHERE(Type = FILTER("Final Roughing"));

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
                field("Planned Date"; Rec."Planned Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planned Date field.';
                }
                field("Final Roughing Completion Date"; Rec."Final Roughing Completion Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Final Roughing Completion Date field.';
                }
                field("No. of OT in 1000 Hill"; Rec."No. of OT in 1000 Hill")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of OT in 1000 Hill field.';
                }
                field("Types of OT"; Rec."Types of OT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Types of OT field.';
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

