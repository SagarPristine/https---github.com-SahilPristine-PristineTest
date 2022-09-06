codeunit 50002 Eventsubscriber

{
    Permissions = tabledata "Item Ledger Entry" = imd;
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

    local procedure FlowCustomFieldsinILE()
    var
        myInt: Integer;
    begin


    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesLine', '', true, true)]
    local procedure OnAfterCopyItemJnlLineFromSalesLine(var ItemJnlLine: Record "Item Journal Line"; SalesLine: Record "Sales Line")
    var
        Item: Record Item;
        SalesHeader: Record "Sales Header";
    begin
        Item.GET(SalesLine."No.");
        ItemJnlLine."Crop Code" := Item."Crop Code";
        ItemJnlLine."Class of Seeds" := Item."Class of Seeds";
        ItemJnlLine."Item Type" := Item."Item Type";
        ItemJnlLine."FG Pack Size" := Item."FG Pack Size";
        ItemJnlLine."Variety Code" := Item."Variety Code";
        SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        SalesHeader.TESTFIELD(Season);
        ItemJnlLine."Season Code" := SalesHeader.Season;
        ItemJnlLine."Land in Acre" := SalesLine."Land in Acre";
        ItemJnlLine."Crop Type" := Item."Crop Type";
        ItemJnlLine."Hybrid Type" := Item."Hybrid Type";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    var
        Item: Record Item;
    begin
        Item.GET(NewItemLedgEntry."Item No.");
        NewItemLedgEntry."Crop Code" := Item."Crop Code";
        NewItemLedgEntry."Class of Seeds" := Item."Class of Seeds";
        NewItemLedgEntry."Item Type" := Item."Item Type";
        NewItemLedgEntry."FG Pack Size" := Item."FG Pack Size";
        NewItemLedgEntry."Variety Code" := Item."Variety Code";
        NewItemLedgEntry."Season Code" := ItemJournalLine."Season Code";
        NewItemLedgEntry."Land in Acre" := ItemJournalLine."Land in Acre";
        NewItemLedgEntry."Crop Type" := Item."Crop Type";
        NewItemLedgEntry."Hybrid Type" := Item."Hybrid Type";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInsertItemLedgEntry', '', true, true)]
    local procedure OnAfterInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer; var ValueEntryNo: Integer; var ItemApplnEntryNo: Integer; GlobalValueEntry: Record "Value Entry"; TransferItem: Boolean; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; var OldItemLedgerEntry: Record "Item Ledger Entry")
    var
        ItemLedgerEntry1: record "Item Ledger Entry";
    begin
        ItemLedgerEntry1 := ItemLedgerEntry;
        ItemLedgerEntry1."Crop Code" := ItemJournalLine."Crop Code";
        ItemLedgerEntry1."Class of Seeds" := ItemJournalLine."Class of Seeds";
        ItemLedgerEntry1."Item Type" := ItemJournalLine."Item Type";
        ItemLedgerEntry1."FG Pack Size" := ItemJournalLine."FG Pack Size";
        ItemLedgerEntry1."Production Code" := ItemJournalLine."Production Code";
        ItemLedgerEntry1."Marketing Code" := ItemJournalLine."Marketing Code";
        ItemLedgerEntry1."Variety Code" := ItemJournalLine."Variety Code";
        ItemLedgerEntry1."Loss Type" := ItemJournalLine."Loss Type";
        ItemLedgerEntry1."Season Code" := ItemJournalLine."Season Code";
        ItemLedgerEntry1."Land in Acre" := ItemJournalLine."Land in Acre";
        ItemLedgerEntry1."Crop Type" := ItemJournalLine."Crop Type";
        ItemLedgerEntry1."Hybrid Type" := ItemJournalLine."Hybrid Type";
        ItemJournalLine.CalcFields("Item Name");
        ItemLedgerEntry1."Item Name" := ItemJournalLine."Item Name";
        ItemLedgerEntry1."Expiry Date" := ItemJournalLine."Expiry Date";
        ItemLedgerEntry1."Packing By" := ItemJournalLine."Packing By";
        ItemLedgerEntry1."Quality Test Date" := ItemJournalLine."Quality Test Date";
        ItemLedgerEntry1.RVD := ItemJournalLine.RVD;
        ItemLedgerEntry1."No. of Bottles" := ItemJournalLine."No. of Bottles";
        ItemLedgerEntry1."Batch No." := ItemJournalLine."Batch No.";
        ItemLedgerEntry1.Blended := ItemJournalLine.Blended;
        ItemLedgerEntry1.RIB := ItemJournalLine.RIB;
        ItemLedgerEntry1."No. of Packages" := ItemJournalLine."No. of Packages";
        ItemLedgerEntry1.Manufacturer := ItemJournalLine.Manufacturer;
        ItemLedgerEntry1."Mfg. Date" := ItemJournalLine."Mfg. Date";
        ItemLedgerEntry1.Modify();
    end;


    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnAfterCreateReservEntry', '', false, false)]
    local procedure ItemTrackingLinesOnRegisterChangeOnAfterCreateReservEntry(var ReservEntry: Record "Reservation Entry"; OldTrackingSpecification: Record "Tracking Specification")
    begin
        ReservEntry."No. of Bags/Pckt" := OldTrackingSpecification."No. of Bags/Pckt";
        ReservEntry.Modify();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCopyTrackingSpec', '', false, false)]
    local procedure ItemTrackingLinesOnAfterCopyTrackingSpec(var DestTrkgSpec: Record "Tracking Specification"; var SourceTrackingSpec: Record "Tracking Specification")
    begin
        DestTrkgSpec."No. of Bags/Pckt" := SourceTrackingSpec."No. of Bags/Pckt";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterEntriesAreIdentical', '', false, false)]
    local procedure ItemTrackingLinesOnAfterEntriesAreIdentical(ReservEntry1: Record "Reservation Entry"; ReservEntry2: Record "Reservation Entry"; var IdenticalArray: array[2] of Boolean)
    begin

        IdenticalArray[2] := IdenticalArray[2] and (ReservEntry1."No. of Bags/Pckt" = ReservEntry2."No. of Bags/Pckt");
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterMoveFields', '', false, false)]
    local procedure ItemTrackingLinesOnAfterMoveFields(var ReservEntry: Record "Reservation Entry"; var TrkgSpec: Record "Tracking Specification")
    begin
        ReservEntry."No. of Bags/Pckt" := TrkgSpec."No. of Bags/Pckt";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertSetupTempSplitItemJnlLine', '', false, false)]
    local procedure ItemJnlPostLineOnBeforeInsertSetupTempSplitItemJnlLine(var TempTrackingSpecification: Record "Tracking Specification"; var TempItemJournalLine: Record "Item Journal Line")
    begin
        TempItemJournalLine."No. of Bags/Pckt" := TempTrackingSpecification."No. of Bags/Pckt"
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure ItemJnlPostLineOnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        NewItemLedgEntry."No. of Bags/Pckt" := ItemJournalLine."No. of Bags/Pckt";
    end;

    //Get Lots
    procedure GetSelectedLotDetails(VAR ILE: Record "Item Ledger Entry"): Text
    var
        myInt: Integer;
        RecRef: RecordRef;
    begin
        RecRef.GETTABLE(ILE);
        EXIT(GetSelectionFilter(RecRef, ILE.FIELDNO("Entry No.")));
    end;
    //Get Lots

    //Get DO Lines
    procedure GetSelectedDOLines(VAR DSL: Record "Delivery Sales line"): Text
    var
        myInt: Integer;
        RecRef: RecordRef;
    begin
        RecRef.GETTABLE(DSL);
        EXIT(GetSelectionFilter(RecRef, DSL.FIELDNO("Line No.")));
    end;
    //Get Lots

    local procedure AddQuotes(inString: Text[1024]): Text
    var
        myInt: Integer;
    begin
        IF DELCHR(inString, '=', ' &|()*') = inString THEN
            EXIT(inString);
        EXIT('''' + inString + '''');
    end;

    local procedure GetSelectionFilter(VAR TempRecRef: RecordRef; SelectionFieldID: Integer): Text
    var
        myInt: Integer;
        RecRef: RecordRef;
        FieldRef: FieldRef;
        FirstRecRef: Text;
        LastRecRef: Text;
        SelectionFilter: Text;
        SavePos: Text;
        TempRecRefCount: Integer;
        More: Boolean;
    begin
        IF TempRecRef.ISTEMPORARY THEN BEGIN
            RecRef := TempRecRef.DUPLICATE;
            RecRef.RESET;
        END ELSE
            RecRef.OPEN(TempRecRef.NUMBER);

        TempRecRefCount := TempRecRef.COUNT;
        IF TempRecRefCount > 0 THEN BEGIN
            TempRecRef.ASCENDING(TRUE);
            TempRecRef.FIND('-');
            WHILE TempRecRefCount > 0 DO BEGIN
                TempRecRefCount := TempRecRefCount - 1;
                RecRef.SETPOSITION(TempRecRef.GETPOSITION);
                RecRef.FIND;
                FieldRef := RecRef.FIELD(SelectionFieldID);
                FirstRecRef := FORMAT(FieldRef.VALUE);
                LastRecRef := FirstRecRef;
                More := TempRecRefCount > 0;
                WHILE More DO
                    IF RecRef.NEXT = 0 THEN
                        More := FALSE
                    ELSE BEGIN
                        SavePos := TempRecRef.GETPOSITION;
                        TempRecRef.SETPOSITION(RecRef.GETPOSITION);
                        IF NOT TempRecRef.FIND THEN BEGIN
                            More := FALSE;
                            TempRecRef.SETPOSITION(SavePos);
                        END ELSE BEGIN
                            FieldRef := RecRef.FIELD(SelectionFieldID);
                            LastRecRef := FORMAT(FieldRef.VALUE);
                            TempRecRefCount := TempRecRefCount - 1;
                            IF TempRecRefCount = 0 THEN
                                More := FALSE;
                        END;
                    END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstRecRef = LastRecRef THEN
                    SelectionFilter := SelectionFilter + AddQuotes(FirstRecRef)
                ELSE
                    SelectionFilter := SelectionFilter + AddQuotes(FirstRecRef) + '..' + AddQuotes(LastRecRef);
                IF TempRecRefCount > 0 THEN
                    TempRecRef.NEXT;
            END;
            EXIT(SelectionFilter);
        END;

    end;

}