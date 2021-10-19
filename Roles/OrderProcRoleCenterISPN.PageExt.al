pageextension 50098 "Order Processor Insights ACK" extends "Order Processor Role Center"
{
    layout
    {
        addafter(Control1901851508)
        {
            part("Order Processor Insights ACK"; "Order Processor Insights ACK")
            {
                ApplicationArea = All;
                Caption = 'Car Insights';
            }
        }
    }
    actions
    {
        addlast(Sections)
        {
            group("Cars Grp ACK")
            {
                Caption = 'Cars';

                action("Cars ACK")
                {
                    Caption = 'Cars';
                    RunObject = page "Car List ACK";
                    ApplicationArea = All;
                    Image = Item;
                    ToolTip = 'Open the car list.';
                }
                action("Makes ACK")
                {
                    Caption = 'Makes';
                    RunObject = page "Make List ACK";
                    ApplicationArea = All;
                    Image = Item;
                    ToolTip = 'Open the make list.';
                }
                action("Setup ACK")
                {
                    Caption = 'Setup';
                    RunObject = page "Setup Card ACK";
                    ApplicationArea = All;
                    Image = Setup;
                    ToolTip = 'Set up the car extension.';
                }
            }
        }
    }
}