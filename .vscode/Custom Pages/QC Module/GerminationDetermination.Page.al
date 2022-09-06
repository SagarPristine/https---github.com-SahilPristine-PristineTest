page 50141 "Germination Determination1"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Germination Evaluation";
    ApplicationArea = all;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Crop Code"; "Crop Code")
                {
                    ApplicationArea = all;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = all;
                }
                field("Item Name"; "Item Name")
                {
                    ApplicationArea = all;
                }
                field("Item Product Group Code"; "Item Product Group Code")
                {
                    ApplicationArea = all;
                }
                field("Item Class of Seeds"; "Item Class of Seeds")
                {
                    ApplicationArea = all;
                }

                field("Qty (Kg)"; "Qty (Kg)")
                {
                    ApplicationArea = all;
                }
                field("Bute No."; "Bute No.")
                {
                    ApplicationArea = all;
                }
                field(Stage; Stage)
                {
                    ApplicationArea = all;
                }
                field("Received Date Time"; "Received Date Time")
                {
                    ApplicationArea = all;
                }
                field("Date of Putting"; "Date of Putting")
                {
                    ApplicationArea = all;
                }
                field("Date of Test"; "Date of Test")
                {
                    ApplicationArea = all;
                }
                field("Sample Code"; "Sample Code")
                {
                    ApplicationArea = all;
                }
                field("Subjected to Count II"; "Subjected to Count II")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        IF Rec."Subjected to Count II" = FALSE THEN
                            Count2Editable := FALSE
                        ELSE
                            Count2Editable := TRUE;
                        CurrPage.UPDATE;
                    end;
                }
            }
            fixed("Count I")
            {
                group("R-I")
                {
                    Caption = 'R-I';
                    field("Count I R-I NSL"; "Count I R-I NSL")
                    {
                        Caption = 'Normal Seed Lings   ';
                        ApplicationArea = all;
                        trigger OnValidate()
                        begin
                            //IF Rec."Count I R-I NSL" <> 0 THEN BEGIN
                            //Rec.VALIDATE("Count I Total NSL",Rec."Count I R-I NSL");
                            //Rec.VALIDATE("Count I %",(Rec."Count I R-I NSL")/4);
                            IF "Count I R-I NSL" > 100 THEN
                                ERROR('You cannot enter more than 100');
                            MaxNSLPrcntge := FALSE;
                            NSLPrcntge := FALSE;
                            IF Rec."Count I %" <> 0 THEN BEGIN
                                //Codeunit50000.CalculateResult(Rec."Item No.", 6, Rec."Count I %", NSLPrcntge, MaxNSLPrcntge);
                                IF (NSLPrcntge = TRUE) AND (MaxNSLPrcntge = TRUE) THEN
                                    Count2Editable := FALSE
                                ELSE
                                    Count2Editable := TRUE;
                            END;
                            //END;
                            Rec.VALIDATE("Count I R-I T", Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Count I R-I ASL"; "Count I R-I ASL")
                    {
                        Caption = 'Abnormal Seed Lings';
                        ApplicationArea = all;
                        trigger OnValidate()
                        begin
                            IF "Count I R-I ASL" > 100 THEN
                                ERROR('You cannot enter more than 100');
                            //IF Rec."Count I R-I ASL" <> 0 THEN
                            //Rec.VALIDATE("Count I Total ASL",Rec."Count I R-I ASL");
                            //Rec.VALIDATE("Count I R-I T",Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                        end;
                    }
                    field("Count I R-I FUG"; "Count I R-I FUG")
                    {
                        Caption = 'Fresh Un-Germinated';
                        ApplicationArea = all;
                        trigger OnValidate()
                        begin
                            IF "Count I R-I FUG" > 100 THEN
                                ERROR('You cannot enter more than 100');

                            //IF Rec."Count I R-I FUG" <> 0 THEN
                            //Rec.VALIDATE("Count I Total FUG",Rec."Count I R-I FUG");
                            //Rec.VALIDATE("Count I R-I T",Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                        end;
                    }
                    field("Count I R-I HS"; "Count I R-I HS")
                    {
                        Caption = 'Hard Seed                     ';
                        ApplicationArea = all;
                        trigger OnValidate()
                        begin
                            IF "Count I R-I HS" > 100 THEN
                                ERROR('You cannot enter more than 100');

                            //IF Rec."Count I R-I HS" <> 0 THEN
                            //Rec.VALIDATE("Count I Total HS",Rec."Count I R-I HS");
                            //Rec.VALIDATE("Count I R-I T",Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                        end;
                    }
                    field("Count I R-I DS"; "Count I R-I DS")
                    {
                        Caption = 'Dead Seed ';

                        trigger OnValidate()
                        begin
                            IF "Count I R-I DS" > 100 THEN
                                ERROR('You cannot enter more than 100');

                            //IF Rec."Count I R-I DS" <> 0 THEN
                            //Rec.VALIDATE("Count I Total DS",Rec."Count I R-I DS");
                            //Rec.VALIDATE("Count I R-I T",Rec."Count I R-I NSL" + Rec."Count I R-I ASL" + Rec."Count I R-I FUG" + Rec."Count I R-I HS" + Rec."Count I R-I DS");
                        end;
                    }
                    field("Count I R-I T"; "Count I R-I T")
                    {
                        Caption = 'Total';
                        ApplicationArea = all;
                    }
                    field("11"; varable)
                    {
                        Editable = false;
                        Enabled = false;
                        Lookup = true;
                        ShowCaption = false;
                    }
                    field("1<Control1000000158>"; varable)
                    {
                        Editable = false;
                        Enabled = false;
                        Lookup = true;
                        ShowCaption = false;

                    }
                }

                grid(Test3)
                {
                    GridLayout = Rows;
                    group("R-II")
                    {
                        Caption = 'R-II';
                        field("Count I R-II NSL"; "Count I R-II NSL")
                        {
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                //IF Rec."Count I R-II NSL" <> 0 THEN BEGIN
                                //Rec.VALIDATE("Count I Total NSL",Rec."Count I R-I NSL" + Rec."Count I R-II NSL");
                                //Rec.VALIDATE("Count I %",(Rec."Count I R-I NSL" + Rec."Count I R-II NSL")/4);
                                MaxNSLPrcntge := FALSE;
                                NSLPrcntge := FALSE;
                                IF Rec."Count I %" <> 0 THEN BEGIN
                                    //Codeunit50000.CalculateResult(Rec."Item No.", 6, Rec."Count I %", NSLPrcntge, MaxNSLPrcntge);
                                    IF (NSLPrcntge = TRUE) AND (MaxNSLPrcntge = TRUE) THEN
                                        Count2Editable := FALSE
                                    ELSE
                                        Count2Editable := TRUE;
                                END;
                                //END;
                                Rec.VALIDATE("Count I R-II T", Rec."Count I R-II NSL" + Rec."Count I R-II ASL" + Rec."Count I R-II FUG" + Rec."Count I R-II HS" + Rec."Count I R-II DS");
                                CurrPage.UPDATE;
                            end;
                        }
                        field("Count I R-II ASL"; "Count I R-II ASL")
                        {
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                //IF Rec."Count I R-II ASL" <> 0 THEN
                                //Rec.VALIDATE("Count I Total ASL",Rec."Count I R-I ASL" + Rec."Count I R-II ASL");
                                //Rec.VALIDATE("Count I R-II T",Rec."Count I R-II NSL" + Rec."Count I R-II ASL" + Rec."Count I R-II FUG" + Rec."Count I R-II HS" + Rec."Count I R-II DS");
                            end;
                        }
                        field("Count I R-II FUG"; "Count I R-II FUG")
                        {
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                //IF Rec."Count I R-II FUG" <> 0 THEN
                                //Rec.VALIDATE("Count I Total FUG",Rec."Count I R-I FUG" + Rec."Count I R-II FUG");
                                //Rec.VALIDATE("Count I R-II T",Rec."Count I R-II NSL" + Rec."Count I R-II ASL" + Rec."Count I R-II FUG" + Rec."Count I R-II HS" + Rec."Count I R-II DS");
                            end;
                        }
                        field("Count I R-II HS"; "Count I R-II HS")
                        {
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                //IF Rec."Count I R-II HS" <> 0 THEN
                                //Rec.VALIDATE("Count I Total HS",Rec."Count I R-I HS" + Rec."Count I R-II HS");
                                //Rec.VALIDATE("Count I R-II T",Rec."Count I R-II NSL" + Rec."Count I R-II ASL" + Rec."Count I R-II FUG" + Rec."Count I R-II HS" + Rec."Count I R-II DS");
                            end;
                        }
                        field("Count I R-II DS"; "Count I R-II DS")
                        {
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                //IF Rec."Count I R-II DS" <> 0 THEN
                                //Rec.VALIDATE("Count I Total DS",Rec."Count I R-I DS" + Rec."Count I R-II DS");
                                //Rec.VALIDATE("Count I R-II T",Rec."Count I R-II NSL" + Rec."Count I R-II ASL" + Rec."Count I R-II FUG" + Rec."Count I R-II HS" + Rec."Count I R-II DS");
                            end;
                        }
                        field("Count I R-II T"; "Count I R-II T")
                        {
                            ShowCaption = false;
                        }
                        field("0<Control1000000070>"; varable)
                        {
                            Editable = false;
                            Enabled = false;
                            Lookup = true;
                            ShowCaption = false;
                        }
                        field("11<Control1000000158>"; varable)
                        {
                            Editable = false;
                            Enabled = false;
                            Lookup = true;
                            ShowCaption = false;
                        }
                    }
                }


            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF Rec."Count I Result" <> Rec."Count I Result"::" " THEN BEGIN
                        Rec.Posted := TRUE;
                        Rec.MODIFY;
                        //ProcessTransferPostYesNo.UpdateQCResultDeclaration("Bute No.", "Sample Code", 3, Results,
                        //            "Final Result User Id", "Date of Test", Results);
                    END ELSE
                        ERROR('Count I Result is not declared yet. Please declare it first.');
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec.Posted = TRUE THEN
            editvalue := FALSE
        ELSE
            editvalue := TRUE;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //UserPermission
        ProcessTransferPostYesNo.UserLocationUserPermission(CanInsert);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //UserPermission
        ProcessTransferPostYesNo.UserLocationUserPermission(CanInsert);
        //CurrPage.UPDATE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //UserPermission
        ProcessTransferPostYesNo.UserLocationUserPermission(CanInsert);
    end;

    trigger OnOpenPage()
    begin
        //UserPermission
        //Check already exist or not
        // CanView := FALSE;
        // ProcessTransferPostYesNo.FetchAllLocationsOfUser(Var_Locations);
        // ProcessTransferPostYesNo.UserLocationWiseCanViewCanInsertDNULW(CanView, CanInsert, Var_Locations, 17);
        // IF CanView = FALSE THEN
        //     ERROR(ContactAdminText003)
        // ELSE BEGIN
        //     IF CanInsert <> TRUE THEN
        //         CurrPage.EDITABLE(FALSE);
        // END;

        // IF Rec."Subjected to Count II" = FALSE THEN
        //     Count2Editable := FALSE
        // ELSE
        //     Count2Editable := TRUE;
    end;

    var
        Var_Locations: Text;
        ProcessTransferPostYesNo: Codeunit 50000;
        Count2Editable: Boolean;
        varable: Text;
        NSLPrcntge: Boolean;
        Codeunit50000: Codeunit 50000;
        recUL: Record "User Location";
        CanView: Boolean;
        CanInsert: Boolean;
        ContactAdminText003: Label 'User doesnot have permission to Create or Modify Record. Please contact your System Administrator.';
        MaxNSLPrcntge: Boolean;
        editvalue: Boolean;
}

