#pragma warning disable
page 50050 "Crop Stage Master List"
{
    PageType = List;
    SourceTable = "Crop Stage Master";
    SourceTableView = SORTING("Crop Code", Sequence)
                      ORDER(Ascending);
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Crop Code"; "Crop Code")
                {
                    ApplicationArea = all;
                }
                field(Stage; Stage)
                {
                    ApplicationArea = all;
                }
                field(Sequence; Sequence)
                {
                    ApplicationArea = all;
                }
                field("Lint/Remenant"; "Lint/Remenant")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(GOT; GOT)
                {
                    ApplicationArea = all;
                }
                field(BT; BT)
                {
                    ApplicationArea = all;
                }
                field("Germination Determination"; "Germination Determination")
                {
                    ApplicationArea = all;
                }
                field("Physical Purity Determination"; "Physical Purity Determination")
                {
                    ApplicationArea = all;
                }
                field("Moisture Determination"; "Moisture Determination")
                {
                    ApplicationArea = all;
                }
                field(NAOH; NAOH)
                {
                    ApplicationArea = all;
                }
                field(EC; EC)
                {
                    ApplicationArea = all;
                }
                field("Chlorophyll Test"; "Chlorophyll Test")
                {
                    ApplicationArea = all;
                }
                field(AAT; AAT)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("HT Herbicide tolerance"; "HT Herbicide tolerance")
                {
                    ApplicationArea = all;
                }
                field("Soil emergence"; "Soil emergence")
                {
                    ApplicationArea = all;
                }
                field("Phenol Test"; "Phenol Test")
                {
                    ApplicationArea = all;
                }
                field("Blend Allowed"; "Blend Allowed")
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
        recUL: Record "User Location";
        CanView: Boolean;
        CanInsert: Boolean;
        ContactAdminText003: Label 'User doesnot have permission to Create or Modify Record. Please contact your System Administrator.';
        Var_Locations: Text;
        ProcessTransferPostYesNo: Codeunit 50000;
}

