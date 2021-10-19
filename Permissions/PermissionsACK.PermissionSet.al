permissionset 50000 "Permissions ACK"
{
    Access = Internal;
    Assignable = true;
    Caption = 'A';
    Permissions =
        table "Car ACK" = X,
        tabledata "Car ACK" = RMID,

        table "Make ACK" = X,
        tabledata "Make ACK" = RMID,

        table "Attachment ACK" = X,
        tabledata "Attachment ACK" = RMID,

        table "Blob Helper ACK" = X,
        tabledata "Blob Helper ACK" = RMID,

        table "Model ACK" = X,
        tabledata "Model ACK" = RMID,

        table "Cue ACK" = X,
        tabledata "Cue ACK" = RMID,

        table "Setup ACK" = X,
        tabledata "Setup ACK" = RMID;
}