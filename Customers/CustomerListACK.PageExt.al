pageextension 50002 "Customer List ACK" extends "Customer List"
{
    layout
    {
        addafter(Contact)
        {
            field("No. of Cars"; Rec."No. of Cars")
            {
                ToolTip = 'Specifies the value of the No. of Cars field.';
                ApplicationArea = All;
            }
        }
    }
}
