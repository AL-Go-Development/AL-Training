page 50010 "Car API ACK"
{
    Extensible = false;
    APIGroup = 'carApp';
    APIPublisher = 'alGo';
    APIVersion = 'v1.0';
    Caption = 'Car API';
    DelayedInsert = true;
    EntityName = 'car';
    EntitySetName = 'cars';
    PageType = API;
    SourceTable = "Car ACK";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                }
                field(customerNo; Rec."Customer No.")
                {
                }
                field(makeCode; Rec."Make Code")
                {
                }
                field(modelCode; Rec."Model Code")
                {
                }
                field(makeDescription; Rec."Make Description")
                {
                }
                field(modelDescription; Rec."Model Description")
                {
                }
                field(vin; Rec.VIN)
                {
                }
                field(description; Rec.GetDescription())
                {
                }
                field(bodyType; Rec."Body Type")
                {
                }
                field(engineType; Rec."Engine Type")
                {
                }
                field(weight; Rec.Weight)
                {
                }
                field(systemId; Rec.SystemId)
                {
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                }
            }
        }
    }
}