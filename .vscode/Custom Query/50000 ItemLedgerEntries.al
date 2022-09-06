query 50000 "Inventory Avai."
{
    QueryType = Normal;

    elements
    {
        dataitem(DataItemName; "Item Ledger Entry")
        {
            column(ItemNo; "Item No.")
            {

            }
            column(LotNo; "Lot No.")
            {
            }
            column(VariantCode; "Variant Code")
            {
            }
            column(NoofBagsPckt; "No. of Bags/Pckt")
            {
            }
            column(RemainingQuantity; "Remaining Quantity")
            {
            }

        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}