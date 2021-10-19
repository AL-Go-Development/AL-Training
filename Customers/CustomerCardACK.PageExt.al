pageextension 50001 "Customer Card ACK" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("No. of Cars"; Rec."No. of Cars")
            {
                ToolTip = 'Specifies the value of the No. of Cars field.';
                ApplicationArea = All;
            }
        }
    }
}