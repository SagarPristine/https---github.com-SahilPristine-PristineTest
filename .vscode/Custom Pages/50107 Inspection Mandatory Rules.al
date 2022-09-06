page 50107 "Inspection Mandatory Rules"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Inspection Mandatory Rules";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Variety Code"; Rec."Variety Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Variety Code field.';
                }

                field(Nursery; Rec.Nursery)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nursery field.';
                }

                field(Vegetative; Rec.Vegetative)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vegetative field.';
                }
                field(Isolation; Rec.Isolation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Isolation field.';
                }
                field("Vegetative Roughing"; Rec."Vegetative Roughing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vegetative Roughing field.';
                }

                field("Pre-Flowering"; Rec."Pre-Flowering")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pre-Flowering field.';
                }
                field(Flowering; Rec.Flowering)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Flowering field.';
                }
                field(Pollination; Rec.Pollination)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pollination field.';
                }
                field(MaleChopping; Rec.MaleChopping)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the MaleChopping field.';
                }
                field("Final Roughing"; Rec."Final Roughing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Final Roughing field.';
                }
                field(Harvesting; Rec.Harvesting)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Harvesting field.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}