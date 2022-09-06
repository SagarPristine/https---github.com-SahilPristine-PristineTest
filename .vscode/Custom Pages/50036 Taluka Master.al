page 50036 "Taluka Master"
{
    PageType = List;
    SourceTable = "Taluka Master";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; REc.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
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

