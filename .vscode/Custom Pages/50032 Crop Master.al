page 50032 "Crop Master"
{
    PageType = List;
    SourceTable = "Crop Master";
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Expiration Date Calc."; Rec."Expiration Date Calc.")
                {
                    ApplicationArea = all;
                }
                field("Near By Expiration Calc."; Rec."Near By Expiration Calc.")
                {
                    ApplicationArea = all;
                }
                field("Image Url"; Rec."Image Url")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin

    end;

    trigger OnModifyRecord(): Boolean
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    trigger OnOpenPage()
    begin
    end;

    var

}

