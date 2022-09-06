#pragma warning disable AL0604
page 50056 "Delivery Sales Subform"
{
    //PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Delivery Sales line";
    AutoSplitKey = true;
    PageType = List;
    RefreshOnActivate = true;



    layout
    {
        area(Content)
        {
            repeater(Subform)
            {

                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Crop Code"; Rec."Crop Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Crop Code field.';
                }
                field("Class of seeds"; Rec."Class of seeds")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Class of seeds field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Item Name"; Rec."Item Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Name field.';
                }
                field("No. of bags"; Rec."No. of bags")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of bags field.';
                }

                field("FG Pack Size"; Rec."FG Pack Size")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FG Pack Size field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Variety Code"; Rec."Variety Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Variety Code field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }


            }

        }

    }
    actions
    {

        area(processing)
        {



        }
    }
    procedure GetSelectionFilterDOLines(): Text
    var
        myInt: Integer;
        DeliverySalesLines: Record "Delivery Sales line";
        Codeunit50002: Codeunit 50002;
    begin
        CurrPage.SETSELECTIONFILTER(DeliverySalesLines);
        EXIT(Codeunit50002.GetSelectedDOLines(DeliverySalesLines));
    end;






    var

}

