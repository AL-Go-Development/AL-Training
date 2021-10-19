page 50009 "Image Preview Factbox ACK"
{
    Extensible = false;
    PageType = CardPart;
    SourceTable = "Attachment ACK";
    Caption = 'Image Preview';

    layout
    {
        area(content)
        {
            field("Image Data"; Rec."Image Data")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the image.';
            }
        }
    }
}