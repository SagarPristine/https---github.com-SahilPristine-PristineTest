pageextension 50127 "Our own headline" extends "Headline RC Business Manager"
{
    layout
    {
        addbefore(Control1)
        {
            field(HeadlineTxt; HeadlineTxt)
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    Hyperlink('https://www.panseeds.in/');
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        HeadlineTxt := 'Hello <emphasize>User!</emphasize> welcome to panseeds';
    end;

    var
        HeadlineTxt: Text;
}