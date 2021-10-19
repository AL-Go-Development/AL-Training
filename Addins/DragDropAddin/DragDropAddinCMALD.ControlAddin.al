controladdin "Drag Drop Addin ACK"
{
    StartupScript = 'Addins/DragDropAddin/js/startup.js';
    StyleSheets = 'Addins/DragDropAddin/css/style.css';
    RequestedHeight = 200;
    MinimumHeight = 200;
    VerticalShrink = false;
    HorizontalStretch = true;
    Scripts = 'Addins/DragDropAddin/js/jquery-1.11.0.min.js',
              'Addins/DragDropAddin/js/jquery-ui.min.js';

    event DataRead(Data: JsonObject);
}