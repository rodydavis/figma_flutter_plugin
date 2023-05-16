import 'dart:ui';
import 'dart:typed_data';
import 'package:flutter/services.dart';

Future<void> loadFonts() async {
  {
    final family = 'MaterialIcons';
    final buffer = Uint8List.fromList([79,84,84,79,0,9,0,128,0,3,0,16,67,70,70,32,181,52,147,138,0,0,8,88,0,0,24,44,79,83,47,50,35,46,89,195,0,0,1,32,0,0,0,96,99,109,97,112,118,162,247,40,0,0,3,128,0,0,4,216,104,101,97,100,31,146,16,44,0,0,0,232,0,0,0,54,104,104,101,97,2,1,2,2,0,0,0,196,0,0,0,36,104,109,116,120,2,0,0,0,0,0,1,128,0,0,0,136,109,97,120,112,0,67,80,0,0,0,0,156,0,0,0,6,110,97,109,101,25,20,52,176,0,0,2,8,0,0,1,118,112,111,115,116,0,3,0,0,0,0,0,164,0,0,0,32,0,0,80,0,0,67,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,2,0,0,0,0,0,2,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,1,0,0,206,244,197,159,95,15,60,245,0,3,2,0,0,0,0,0,223,61,115,134,0,0,0,0,223,62,91,174,0,0,0,0,2,0,2,0,0,0,0,3,0,2,0,0,0,0,0,0,0,4,2,0,1,144,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0,0,0,4,0,0,0,0,0,0,0,63,63,63,63,0,128,224,58,255,255,2,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,90,0,3,0,1,4,9,0,0,0,94,0,190,0,3,0,1,4,9,0,1,0,28,0,162,0,3,0,1,4,9,0,2,0,14,0,148,0,3,0,1,4,9,0,3,0,54,0,94,0,3,0,1,4,9,0,4,0,42,0,52,0,3,0,1,4,9,0,5,0,52,0,0,0,3,0,1,4,9,0,6,0,42,0,52,0,50,0,48,0,50,0,50,0,45,0,48,0,57,0,45,0,48,0,54,0,84,0,49,0,53,0,58,0,48,0,48,0,58,0,51,0,56,0,46,0,56,0,49,0,57,0,57,0,48,0,51,0,77,0,97,0,116,0,101,0,114,0,105,0,97,0,108,0,73,0,99,0,111,0,110,0,115,0,45,0,82,0,101,0,103,0,117,0,108,0,97,0,114,0,77,0,97,0,116,0,101,0,114,0,105,0,97,0,108,0,32,0,73,0,99,0,111,0,110,0,115,0,32,0,58,0,32,0,50,0,48,0,50,0,50,0,45,0,48,0,57,0,45,0,48,0,55,0,82,0,101,0,103,0,117,0,108,0,97,0,114,0,77,0,97,0,116,0,101,0,114,0,105,0,97,0,108,0,32,0,73,0,99,0,111,0,110,0,115,0,67,0,111,0,112,0,121,0,114,0,105,0,103,0,104,0,116,0,32,0,50,0,48,0,49,0,57,0,32,0,71,0,111,0,111,0,103,0,108,0,101,0,32,0,76,0,76,0,67,0,46,0,32,0,65,0,108,0,108,0,32,0,82,0,105,0,103,0,104,0,116,0,115,0,32,0,82,0,101,0,115,0,101,0,114,0,118,0,101,0,100,0,46,0,0,0,0,0,3,0,0,0,3,0,0,3,8,0,3,0,1,0,0,3,8,0,3,0,10,0,0,0,28,0,12,0,0,0,0,2,236,0,0,0,0,0,0,0,61,0,0,224,58,0,0,224,58,0,0,0,1,0,0,224,71,0,0,224,71,0,0,0,2,0,0,224,146,0,0,224,147,0,0,0,3,0,0,224,152,0,0,224,152,0,0,0,11,0,0,224,154,0,0,224,156,0,0,0,12,0,0,224,158,0,0,224,158,0,0,0,21,0,0,224,160,0,0,224,160,0,0,0,22,0,0,225,34,0,0,225,34,0,0,0,23,0,0,225,57,0,0,225,57,0,0,0,24,0,0,225,86,0,0,225,86,0,0,0,25,0,0,225,94,0,0,225,95,0,0,0,26,0,0,225,104,0,0,225,104,0,0,0,28,0,0,225,106,0,0,225,106,0,0,0,29,0,0,225,124,0,0,225,124,0,0,0,30,0,0,225,246,0,0,225,246,0,0,0,31,0,0,226,6,0,0,226,6,0,0,0,32,0,0,226,26,0,0,226,26,0,0,0,33,0,0,226,70,0,0,226,70,0,0,0,35,0,0,226,155,0,0,226,155,0,0,0,36,0,0,226,156,0,0,226,156,0,0,0,40,0,0,227,77,0,0,227,77,0,0,0,44,0,0,227,220,0,0,227,220,0,0,0,49,0,0,228,2,0,0,228,2,0,0,0,50,0,0,228,4,0,0,228,4,0,0,0,54,0,0,228,79,0,0,228,79,0,0,0,58,0,0,229,103,0,0,229,103,0,0,0,59,0,0,229,147,0,0,229,147,0,0,0,61,0,0,229,189,0,0,229,190,0,0,0,65,0,0,231,146,0,0,231,146,0,0,0,7,0,0,231,147,0,0,231,147,0,0,0,10,0,0,231,154,0,0,231,154,0,0,0,17,0,0,231,155,0,0,231,155,0,0,0,20,0,0,233,149,0,0,233,149,0,0,0,39,0,0,233,150,0,0,233,150,0,0,0,43,0,0,234,71,0,0,234,71,0,0,0,47,0,0,234,250,0,0,234,250,0,0,0,53,0,0,234,253,0,0,234,253,0,0,0,57,0,0,236,139,0,0,236,139,0,0,0,64,0,0,238,132,0,0,238,132,0,0,0,5,0,0,238,133,0,0,238,133,0,0,0,8,0,0,238,140,0,0,238,140,0,0,0,15,0,0,238,141,0,0,238,141,0,0,0,18,0,0,240,13,0,0,240,13,0,0,0,34,0,0,240,135,0,0,240,135,0,0,0,37,0,0,240,136,0,0,240,136,0,0,0,41,0,0,241,56,0,0,241,56,0,0,0,45,0,0,241,68,0,0,241,68,0,0,0,48,0,0,241,231,0,0,241,231,0,0,0,51,0,0,241,234,0,0,241,234,0,0,0,55,0,0,243,110,0,0,243,110,0,0,0,60,0,0,243,120,0,0,243,120,0,0,0,62,0,0,245,113,0,0,245,113,0,0,0,6,0,0,245,114,0,0,245,114,0,0,0,9,0,0,245,121,0,0,245,121,0,0,0,16,0,0,245,122,0,0,245,122,0,0,0,19,0,0,247,116,0,0,247,116,0,0,0,38,0,0,247,117,0,0,247,117,0,0,0,42,0,0,248,38,0,0,248,38,0,0,0,46,0,0,248,217,0,0,248,217,0,0,0,52,0,0,248,220,0,0,248,220,0,0,0,56,0,15,1,106,0,15,1,106,0,0,0,63,0,4,1,208,0,0,0,102,0,64,0,5,0,38,224,58,224,71,224,147,224,152,224,156,224,158,224,160,225,34,225,57,225,86,225,95,225,104,225,106,225,124,225,246,226,6,226,26,226,70,226,156,227,77,227,220,228,2,228,4,228,79,229,103,229,147,229,190,231,147,231,155,233,150,234,71,234,250,234,253,236,139,238,133,238,141,240,13,240,136,241,56,241,68,241,231,241,234,243,110,243,120,245,114,245,122,247,117,248,38,248,217,248,220,255,255,0,0,224,58,224,71,224,146,224,152,224,154,224,158,224,160,225,34,225,57,225,86,225,94,225,104,225,106,225,124,225,246,226,6,226,26,226,70,226,155,227,77,227,220,228,2,228,4,228,79,229,103,229,147,229,189,231,146,231,154,233,149,234,71,234,250,234,253,236,139,238,132,238,140,240,13,240,135,241,56,241,68,241,231,241,234,243,110,243,120,245,113,245,121,247,116,248,38,248,217,248,220,255,255,31,199,31,187,31,113,31,115,31,114,31,119,31,118,30,245,30,223,30,195,30,188,30,180,30,179,30,162,30,41,30,26,30,7,29,221,0,0,28,223,28,85,28,48,28,50,27,235,26,212,26,170,26,132,0,0,0,0,0,0,21,232,21,59,21,60,19,181,0,0,0,0,16,21,0,0,14,245,14,236,14,76,14,77,12,206,12,198,0,0,0,0,0,0,8,8,7,91,7,92,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,66,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,52,0,54,0,56,0,0,0,0,0,0,0,0,0,50,0,52,0,0,0,52,0,0,0,0,0,0,0,0,0,0,0,0,0,42,0,44,0,46,0,0,0,0,0,0,0,0,0,36,0,40,0,7,0,10,0,17,0,20,0,39,0,43,0,5,0,8,0,15,0,18,0,37,0,41,0,6,0,9,0,16,0,19,0,38,0,42,1,0,4,4,0,1,1,1,19,65,108,108,51,80,73,99,111,110,115,45,82,101,103,117,108,97,114,0,1,1,1,53,28,1,135,2,30,160,1,149,49,37,255,139,139,30,160,1,149,49,37,255,139,139,12,7,139,139,248,148,248,148,5,29,0,0,5,231,15,28,0,0,29,0,0,0,0,18,29,0,0,5,235,17,0,67,2,0,1,0,19,0,39,0,51,0,70,0,93,0,116,0,138,0,158,0,177,0,195,0,211,0,235,1,1,1,23,1,49,1,75,1,100,1,123,1,145,1,166,1,185,1,205,1,226,1,249,2,8,2,22,2,43,2,65,2,79,2,93,2,112,2,125,2,145,2,158,2,171,2,191,2,219,2,247,3,18,3,43,3,67,3,91,3,114,3,135,3,153,3,171,3,188,3,203,3,220,3,233,3,252,4,15,4,33,4,49,4,67,4,85,4,102,4,117,4,139,4,154,4,171,4,185,4,199,4,212,4,223,4,241,5,7,65,108,108,51,80,73,99,111,110,115,45,82,101,103,117,108,97,114,97,99,99,101,115,115,95,116,105,109,101,95,98,97,115,101,108,105,110,101,97,100,100,95,98,97,115,101,108,105,110,101,97,114,114,111,119,95,98,97,99,107,95,98,97,115,101,108,105,110,101,97,114,114,111,119,95,98,97,99,107,95,105,111,115,95,98,97,115,101,108,105,110,101,97,114,114,111,119,95,98,97,99,107,95,105,111,115,95,111,117,116,108,105,110,101,100,97,114,114,111,119,95,98,97,99,107,95,105,111,115,95,114,111,117,110,100,101,100,97,114,114,111,119,95,98,97,99,107,95,105,111,115,95,115,104,97,114,112,97,114,114,111,119,95,98,97,99,107,95,111,117,116,108,105,110,101,100,97,114,114,111,119,95,98,97,99,107,95,114,111,117,110,100,101,100,97,114,114,111,119,95,98,97,99,107,95,115,104,97,114,112,97,114,114,111,119,95,100,114,111,112,95,100,111,119,110,95,98,97,115,101,108,105,110,101,97,114,114,111,119,95,100,114,111,112,95,117,112,95,98,97,115,101,108,105,110,101,97,114,114,111,119,95,102,111,114,119,97,114,100,95,98,97,115,101,108,105,110,101,97,114,114,111,119,95,102,111,114,119,97,114,100,95,105,111,115,95,98,97,115,101,108,105,110,101,97,114,114,111,119,95,102,111,114,119,97,114,100,95,105,111,115,95,111,117,116,108,105,110,101,100,97,114,114,111,119,95,102,111,114,119,97,114,100,95,105,111,115,95,114,111,117,110,100,101,100,97,114,114,111,119,95,102,111,114,119,97,114,100,95,105,111,115,95,115,104,97,114,112,97,114,114,111,119,95,102,111,114,119,97,114,100,95,111,117,116,108,105,110,101,100,97,114,114,111,119,95,102,111,114,119,97,114,100,95,114,111,117,110,100,101,100,97,114,114,111,119,95,102,111,114,119,97,114,100,95,115,104,97,114,112,97,114,114,111,119,95,114,105,103,104,116,95,98,97,115,101,108,105,110,101,97,114,114,111,119,95,117,112,119,97,114,100,95,98,97,115,101,108,105,110,101,99,97,108,101,110,100,97,114,95,116,111,100,97,121,95,98,97,115,101,108,105,110,101,99,97,110,99,101,108,95,98,97,115,101,108,105,110,101,99,104,101,99,107,95,98,97,115,101,108,105,110,101,99,104,101,118,114,111,110,95,108,101,102,116,95,98,97,115,101,108,105,110,101,99,104,101,118,114,111,110,95,114,105,103,104,116,95,98,97,115,101,108,105,110,101,99,108,101,97,114,95,98,97,115,101,108,105,110,101,99,108,111,115,101,95,98,97,115,101,108,105,110,101,99,111,108,111,114,95,108,101,110,115,95,98,97,115,101,108,105,110,101,100,111,110,101,95,98,97,115,101,108,105,110,101,100,114,97,103,95,104,97,110,100,108,101,95,98,97,115,101,108,105,110,101,101,100,105,116,95,98,97,115,101,108,105,110,101,101,100,105,116,95,111,117,116,108,105,110,101,100,101,120,112,97,110,100,95,109,111,114,101,95,98,97,115,101,108,105,110,101,102,108,105,112,95,99,97,109,101,114,97,95,97,110,100,114,111,105,100,95,98,97,115,101,108,105,110,101,102,108,105,112,95,99,97,109,101,114,97,95,97,110,100,114,111,105,100,95,111,117,116,108,105,110,101,100,102,108,105,112,95,99,97,109,101,114,97,95,97,110,100,114,111,105,100,95,114,111,117,110,100,101,100,102,108,105,112,95,99,97,109,101,114,97,95,97,110,100,114,111,105,100,95,115,104,97,114,112,102,108,105,112,95,99,97,109,101,114,97,95,105,111,115,95,98,97,115,101,108,105,110,101,102,108,105,112,95,99,97,109,101,114,97,95,105,111,115,95,111,117,116,108,105,110,101,100,102,108,105,112,95,99,97,109,101,114,97,95,105,111,115,95,114,111,117,110,100,101,100,102,108,105,112,95,99,97,109,101,114,97,95,105,111,115,95,115,104,97,114,112,105,111,115,95,115,104,97,114,101,95,98,97,115,101,108,105,110,101,105,111,115,95,115,104,97,114,101,95,111,117,116,108,105,110,101,100,105,111,115,95,115,104,97,114,101,95,114,111,117,110,100,101,100,105,111,115,95,115,104,97,114,101,95,115,104,97,114,112,107,101,121,98,111,97,114,100,95,111,117,116,108,105,110,101,100,109,101,110,117,95,98,97,115,101,108,105,110,101,109,111,114,101,95,104,111,114,105,122,95,98,97,115,101,108,105,110,101,109,111,114,101,95,104,111,114,105,122,95,111,117,116,108,105,110,101,100,109,111,114,101,95,104,111,114,105,122,95,114,111,117,110,100,101,100,109,111,114,101,95,104,111,114,105,122,95,115,104,97,114,112,109,111,114,101,95,118,101,114,116,95,98,97,115,101,108,105,110,101,109,111,114,101,95,118,101,114,116,95,111,117,116,108,105,110,101,100,109,111,114,101,95,118,101,114,116,95,114,111,117,110,100,101,100,109,111,114,101,95,118,101,114,116,95,115,104,97,114,112,110,111,116,105,102,105,99,97,116,105,111,110,115,95,98,97,115,101,108,105,110,101,115,101,97,114,99,104,95,98,97,115,101,108,105,110,101,115,101,116,116,105,110,103,115,95,111,117,116,108,105,110,101,100,115,104,97,114,101,95,98,97,115,101,108,105,110,101,115,104,97,114,101,95,111,117,116,108,105,110,101,100,115,104,97,114,101,95,114,111,117,110,100,101,100,115,104,97,114,101,95,115,104,97,114,112,115,107,105,112,95,110,101,120,116,95,98,97,115,101,108,105,110,101,115,107,105,112,95,112,114,101,118,105,111,117,115,95,98,97,115,101,108,105,110,101,0,0,1,1,136,65,0,67,2,0,1,0,4,0,76,0,105,0,141,0,170,0,199,1,1,1,30,1,66,1,135,1,171,1,187,1,203,1,239,2,11,2,39,2,96,2,124,2,160,2,228,3,8,3,24,3,59,3,119,3,181,3,208,3,233,4,2,4,51,4,100,4,229,5,0,5,27,5,76,5,149,5,174,6,22,6,145,7,58,7,162,8,30,8,177,9,77,9,178,9,251,10,68,10,183,10,229,11,111,11,144,11,209,12,18,12,83,12,148,12,212,13,20,13,84,13,148,13,212,14,24,15,148,15,253,16,166,17,15,17,120,17,152,17,183,248,148,14,248,148,247,148,248,105,21,251,10,44,44,251,10,251,10,234,44,247,10,247,10,234,234,247,10,247,10,44,234,251,10,31,252,20,4,45,62,216,233,233,216,216,233,233,216,62,45,45,62,62,45,31,150,247,170,21,107,251,20,6,247,4,71,155,166,43,196,5,247,4,7,14,248,148,248,41,247,127,21,251,20,251,20,97,247,20,251,20,181,247,20,247,20,181,251,20,247,20,97,6,14,248,148,248,63,247,169,21,251,152,6,247,11,247,12,109,169,251,63,251,63,247,63,251,63,169,169,251,11,247,12,5,247,152,181,6,14,248,148,247,141,248,65,21,101,177,251,103,251,103,247,103,251,103,177,177,251,65,247,65,247,65,247,65,5,14,248,148,248,10,248,65,21,101,177,251,103,251,103,247,103,251,103,177,177,251,66,247,65,247,66,247,65,5,14,248,148,247,247,248,84,21,128,150,122,139,129,128,251,69,251,69,24,130,131,139,125,148,131,247,69,251,69,24,149,128,156,139,150,150,149,149,139,156,129,149,8,251,47,247,47,247,47,247,47,149,149,139,156,129,149,25,14,248,148,248,10,248,65,21,101,177,251,103,251,103,247,103,251,103,177,177,251,66,247,65,247,66,247,65,5,14,248,148,248,63,247,169,21,251,152,6,247,11,247,12,109,169,251,63,251,63,247,63,251,63,169,169,251,11,247,12,5,247,152,181,6,14,248,148,248,41,247,169,21,251,130,6,243,243,5,147,148,139,152,131,148,131,147,125,139,131,131,251,33,251,33,24,131,131,139,125,147,131,247,33,251,33,24,147,131,153,139,147,147,147,148,139,152,131,148,35,243,24,247,130,6,151,149,148,151,151,129,148,127,31,14,248,148,248,63,247,169,21,251,152,6,247,11,247,12,109,169,251,63,251,63,247,63,251,63,169,169,251,11,247,12,5,247,152,181,6,14,248,148,247,41,247,191,21,246,32,246,246,5,251,106,6,14,248,148,247,41,247,105,21,246,246,246,32,5,251,106,6,14,248,148,247,148,248,63,21,109,109,247,11,251,12,5,251,152,97,247,152,6,251,11,251,12,169,109,247,63,247,63,251,63,247,63,5,14,248,148,247,25,219,21,177,102,247,105,247,105,251,105,247,105,101,102,247,67,251,68,251,67,251,68,5,14,248,148,247,25,219,21,177,102,247,105,247,105,251,105,247,105,101,102,247,67,251,68,251,67,251,68,5,14,248,148,247,49,203,21,150,128,156,139,149,150,247,69,247,69,24,148,147,139,153,130,147,251,69,247,69,24,129,150,122,139,128,128,129,129,139,122,149,129,8,247,47,251,47,251,47,251,47,129,129,139,122,149,129,25,14,248,148,247,25,219,21,177,102,247,105,247,105,251,105,247,105,101,102,247,67,251,68,251,67,251,68,5,14,248,148,247,148,248,63,21,109,109,247,11,251,12,5,251,152,97,247,152,6,251,11,251,12,169,109,247,63,247,63,251,63,247,63,5,14,248,148,246,247,127,21,247,130,6,35,35,5,131,130,139,126,147,130,147,131,153,139,147,147,247,33,247,33,24,147,147,139,153,131,147,251,33,247,33,24,131,147,125,139,131,131,131,130,139,126,147,131,243,34,24,251,130,6,127,129,130,127,127,149,130,151,31,14,248,148,247,148,248,63,21,109,109,247,11,251,12,5,251,152,97,247,152,6,251,11,251,12,169,109,247,63,247,63,251,63,247,63,5,14,248,148,247,105,247,41,21,246,246,32,246,5,251,106,7,14,248,148,224,247,148,21,169,109,247,12,247,11,5,251,152,181,247,152,7,247,11,251,11,170,169,251,63,247,63,251,63,251,63,5,14,248,148,248,63,248,84,21,117,182,97,96,251,106,182,97,96,117,6,116,120,120,115,31,251,233,7,116,158,119,162,30,247,234,6,162,158,159,162,31,247,233,7,163,120,158,116,30,252,20,4,251,234,247,169,247,234,251,169,6,14,248,148,247,148,248,105,21,251,10,44,44,251,10,251,10,234,44,247,10,247,10,234,234,247,10,247,10,44,234,251,10,31,246,251,182,21,109,109,62,216,62,62,109,169,216,216,62,216,169,169,216,62,216,216,169,109,62,62,216,62,5,14,248,148,247,84,247,59,21,50,228,109,109,247,11,251,11,247,148,247,148,109,169,251,118,251,118,5,14,248,148,247,221,247,246,21,109,169,251,20,251,20,247,20,251,20,169,169,41,237,237,237,5,14,248,148,247,105,248,20,21,109,109,237,41,41,41,169,109,247,20,247,20,251,20,247,20,5,14,248,148,248,41,248,11,21,109,169,251,11,251,11,251,11,247,11,109,109,247,11,251,11,251,11,251,11,169,109,247,11,247,11,247,11,251,11,169,169,251,11,247,11,247,11,247,11,5,14,248,148,248,41,248,11,21,109,169,251,11,251,11,251,11,247,11,109,109,247,11,251,11,251,11,251,11,169,109,247,11,247,11,247,11,251,11,169,169,251,11,247,11,247,11,247,11,5,14,248,148,247,148,248,84,21,33,53,53,33,33,225,53,245,157,153,153,157,147,136,147,134,145,31,134,144,136,147,147,26,156,153,154,157,30,176,6,198,187,186,198,234,53,215,33,31,251,9,251,84,21,121,125,153,157,157,153,153,157,156,154,125,121,121,124,125,122,31,203,224,21,121,125,154,156,157,153,153,157,156,154,125,121,122,124,124,122,31,245,22,122,124,154,156,157,154,153,156,157,153,125,121,122,125,124,121,31,203,54,21,122,124,153,157,157,154,153,156,157,153,125,121,121,125,125,121,31,14,248,148,247,84,247,58,21,49,229,110,109,247,11,251,11,247,148,247,148,109,169,251,118,251,119,5,14,248,148,248,63,247,212,21,251,234,96,247,234,182,6,251,234,251,20,21,247,234,182,251,234,96,6,14,248,148,203,247,36,21,59,219,7,247,128,247,128,59,219,251,128,251,128,5,248,14,247,110,21,147,147,139,153,131,147,8,89,189,131,147,125,139,131,131,25,100,100,219,59,178,178,5,14,248,148,247,192,247,212,21,159,119,251,86,251,85,5,120,158,6,247,85,247,86,5,216,247,20,21,133,134,137,135,135,31,100,100,219,59,178,178,5,147,147,139,153,131,147,89,189,24,143,135,133,141,134,27,62,71,21,251,128,251,128,5,59,219,7,247,128,247,128,59,219,5,14,248,148,247,246,247,221,21,41,41,41,237,109,109,247,20,251,20,247,20,247,20,109,169,5,14,248,148,247,84,247,148,21,104,168,110,174,174,168,168,174,174,110,168,104,104,110,110,104,30,118,182,21,181,77,7,190,168,194,174,202,27,218,206,84,66,158,31,183,6,236,119,53,212,36,27,69,77,106,87,100,31,182,97,251,20,247,20,7,247,62,53,21,97,201,7,88,110,84,104,76,27,60,72,194,212,120,31,95,6,42,159,225,66,242,27,209,201,172,191,178,31,96,181,247,20,251,20,7,14,248,148,247,84,247,148,21,104,168,110,174,174,168,168,174,174,110,168,104,104,110,110,104,30,224,22,127,130,130,127,127,130,148,151,151,148,148,151,151,148,130,127,30,33,182,21,181,77,7,190,168,194,174,202,27,218,206,84,66,158,31,183,6,236,119,53,212,36,27,69,77,106,87,100,31,182,97,251,20,247,20,7,247,62,53,21,97,201,7,88,110,84,104,76,27,60,72,194,212,120,31,95,6,42,159,225,66,242,27,209,201,172,191,178,31,96,181,247,20,251,20,7,14,248,148,247,84,247,148,21,104,168,110,174,174,168,168,174,174,110,168,104,104,110,110,104,30,118,203,21,151,129,148,127,30,99,6,190,168,194,174,202,27,213,203,91,72,162,31,131,142,147,134,148,27,153,150,153,153,134,31,222,110,60,198,46,27,69,77,106,87,100,31,160,7,151,130,149,127,127,130,129,127,30,54,7,127,148,130,151,30,224,6,151,149,148,151,31,247,62,251,20,21,127,149,130,151,30,179,6,88,110,84,104,76,27,65,75,187,206,116,31,147,136,131,144,130,27,125,128,125,125,144,31,56,168,218,80,232,27,209,201,172,191,178,31,118,7,127,148,129,151,151,148,149,151,30,224,7,151,130,148,127,30,54,6,127,129,130,127,31,14,248,148,247,84,247,148,21,104,168,110,174,174,168,168,174,174,110,168,104,104,110,110,104,30,118,182,21,181,77,7,190,168,194,174,202,27,218,206,84,66,158,31,183,6,236,119,53,212,36,27,69,77,106,87,100,31,182,97,251,20,247,20,7,247,62,53,21,97,201,7,88,110,84,104,76,27,60,72,194,212,120,31,95,6,42,159,225,66,242,27,209,201,172,191,178,31,96,181,247,20,251,20,7,14,248,148,248,63,248,41,21,71,6,100,182,251,20,139,100,96,5,71,6,116,120,120,116,31,251,148,7,115,158,120,162,30,247,234,6,162,158,158,163,31,247,148,7,162,120,158,116,30,251,63,251,169,21,80,91,187,198,31,97,6,192,192,192,86,5,97,6,92,177,100,186,151,151,142,144,150,30,154,123,5,131,124,122,134,121,27,235,192,21,86,193,5,181,6,186,101,177,92,127,127,136,135,128,30,124,154,5,147,154,156,144,157,27,198,187,92,80,31,181,6,86,85,5,14,248,148,248,63,248,41,21,71,6,100,182,251,20,139,100,96,5,71,6,116,120,120,116,31,251,148,7,115,158,120,162,30,247,234,6,162,158,158,163,31,247,148,7,162,120,158,116,30,251,190,4,251,234,247,148,226,6,151,153,166,167,229,139,166,111,151,125,5,226,251,148,6,251,63,181,21,92,101,178,186,31,181,6,86,192,86,86,5,181,6,80,187,91,198,157,156,144,147,154,30,124,155,5,134,128,127,136,127,27,247,84,4,121,122,134,131,124,31,154,124,5,143,150,151,142,151,27,186,177,101,92,31,97,6,192,85,192,193,5,97,6,198,91,186,80,30,14,248,148,248,63,248,41,21,71,6,113,168,5,148,131,127,144,127,27,49,6,127,127,134,130,131,31,113,110,5,71,6,116,120,120,116,31,251,148,7,115,158,120,162,30,247,234,6,162,158,158,163,31,247,148,7,162,120,158,116,30,251,27,251,163,21,135,128,127,137,126,27,80,91,187,198,31,97,6,192,192,192,86,5,97,6,92,177,100,186,149,148,141,142,148,30,143,141,143,138,142,136,145,133,137,130,132,136,8,199,186,21,86,193,5,181,6,186,101,177,92,129,130,137,136,130,30,135,138,135,139,136,142,133,145,141,148,146,142,8,143,150,151,141,152,27,198,187,92,80,31,181,6,86,85,5,14,248,148,247,251,248,41,21,100,182,251,20,139,100,96,5,251,2,251,233,248,62,247,233,251,2,6,36,251,169,21,80,91,187,198,31,97,6,192,192,192,86,5,97,6,92,177,100,186,151,151,142,144,150,30,154,123,5,131,124,122,134,121,27,235,192,21,86,193,5,181,6,186,101,177,92,127,127,136,135,128,30,124,154,5,147,154,156,144,157,27,198,187,92,80,31,181,6,86,85,5,14,248,148,247,233,248,41,21,109,109,105,173,5,251,130,97,247,130,7,105,105,109,169,224,225,224,53,5,225,33,21,251,127,7,116,119,119,116,30,251,148,6,115,120,159,162,31,247,127,7,162,158,158,163,30,203,97,75,251,127,247,148,247,127,75,181,203,6,162,159,120,116,31,14,248,148,247,233,248,41,21,109,109,105,173,5,251,130,97,247,130,7,105,105,109,169,224,225,224,53,5,225,33,21,251,127,7,116,119,119,116,30,251,148,6,115,120,159,162,31,247,127,7,162,158,158,163,30,203,97,75,251,127,247,148,247,127,75,181,203,6,162,159,120,116,31,14,248,148,248,20,247,233,21,96,6,128,129,130,127,127,149,130,150,31,182,251,127,251,148,247,127,182,6,150,149,148,151,151,129,148,128,31,96,6,116,119,120,116,31,251,127,7,116,159,119,162,30,247,148,6,162,159,159,162,31,247,127,7,162,119,158,116,30,251,20,251,62,21,151,148,148,151,31,247,105,178,7,148,144,151,145,132,31,79,199,5,135,143,133,139,134,135,80,79,24,133,132,144,127,148,27,178,251,105,6,127,148,130,151,30,14,248,148,248,63,247,233,21,32,97,203,251,127,251,148,247,127,203,181,32,251,212,247,234,247,212,6,251,84,251,62,21,181,247,126,203,6,54,225,54,53,5,203,251,126,6,14,248,148,248,63,247,255,21,251,106,251,234,247,106,247,234,7,181,4,251,234,6,116,120,120,116,31,251,106,7,116,158,120,162,30,247,234,6,162,158,158,162,31,247,106,7,162,120,158,116,30,251,84,75,21,181,97,97,181,6,75,4,181,97,97,181,6,75,203,21,181,97,97,181,6,75,4,181,97,97,181,6,75,22,181,97,97,181,6,203,4,181,97,97,181,6,203,251,20,21,247,62,97,251,62,181,6,247,20,203,21,181,97,97,181,6,203,4,181,97,97,181,6,203,75,21,181,97,97,181,6,203,4,181,97,97,181,6,14,248,148,203,247,20,21,248,20,182,252,20,96,6,246,4,248,20,181,252,20,97,6,247,41,4,96,248,20,182,252,20,7,14,248,148,247,20,247,191,21,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,247,148,22,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,251,20,22,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,14,248,148,247,20,247,191,21,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,247,148,22,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,251,20,22,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,14,248,148,247,20,247,191,21,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,247,148,22,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,251,20,22,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,14,248,148,247,20,247,191,21,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,247,148,22,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,251,20,22,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,14,248,148,247,148,247,233,21,162,159,159,162,162,119,159,116,116,119,119,116,116,159,119,162,31,97,4,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,251,20,4,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,14,248,148,247,148,247,233,21,162,159,159,162,162,119,159,116,116,119,119,116,116,159,119,162,31,97,4,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,251,20,4,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,14,248,148,247,148,247,233,21,162,159,159,162,162,119,159,116,116,119,119,116,116,159,119,162,31,97,4,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,251,20,4,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,14,248,148,247,148,247,233,21,162,159,159,162,162,119,159,116,116,119,119,116,116,159,119,162,31,97,4,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,251,20,4,116,119,119,116,116,159,119,162,162,159,159,162,162,119,159,116,31,14,248,148,247,148,182,21,162,159,158,162,31,53,6,116,158,120,163,30,247,20,247,20,21,245,7,205,104,194,78,153,30,154,7,156,125,154,121,121,125,124,122,30,124,7,78,125,104,84,73,26,33,7,96,96,5,118,247,234,160,7,96,182,5,14,248,148,247,223,247,105,21,122,6,133,145,5,160,163,151,171,173,26,216,77,201,63,62,77,77,62,63,201,77,216,173,171,151,160,163,30,145,133,139,122,245,33,171,171,33,245,5,251,20,22,86,96,182,192,192,182,182,192,192,182,96,86,86,96,96,86,31,14,248,148,248,51,247,127,21,146,140,146,146,146,138,146,146,26,184,174,5,143,142,140,145,136,144,96,213,24,142,137,136,141,135,27,138,137,139,138,138,31,86,118,5,128,147,127,147,126,144,131,195,24,144,138,135,143,134,27,53,6,134,135,135,134,138,31,131,83,5,126,134,127,131,128,131,86,160,24,140,137,138,139,138,27,135,136,137,136,137,31,96,65,5,136,134,140,133,143,136,184,104,24,132,138,132,132,132,140,132,132,26,94,104,5,135,136,138,133,142,134,182,65,24,136,141,142,137,143,27,140,141,139,140,140,31,192,160,5,150,131,151,131,152,134,147,83,24,134,140,143,135,144,27,225,6,144,143,143,144,140,31,147,195,5,152,144,151,147,150,147,192,118,24,138,141,140,139,140,27,143,142,141,142,141,31,182,213,5,142,144,138,145,135,142,94,174,24,96,176,21,140,132,139,134,135,26,135,139,134,138,132,30,136,115,158,124,162,121,124,114,112,150,117,147,120,125,130,132,130,134,130,135,25,117,130,135,115,135,110,109,139,135,168,136,163,116,148,130,143,130,144,131,146,25,119,153,117,130,112,128,124,165,162,157,158,154,136,163,5,138,146,139,144,143,26,143,139,144,140,146,30,142,163,120,154,116,157,154,164,166,128,161,131,158,153,148,146,148,144,148,143,25,161,148,143,163,143,168,169,139,143,110,142,115,162,130,148,135,148,134,147,132,25,158,125,162,148,166,150,154,113,116,121,120,124,142,115,5,251,8,208,21,92,101,101,92,92,177,101,186,186,177,177,186,186,101,177,92,31,251,20,4,116,119,159,162,162,159,159,162,162,159,119,116,116,119,119,116,31,14,248,148,248,20,247,61,21,123,124,133,129,128,31,251,44,227,5,140,144,140,144,144,26,144,138,144,138,144,30,247,42,227,5,128,151,154,132,156,27,174,168,168,174,175,110,167,104,104,110,111,103,134,140,134,140,134,31,251,42,52,5,149,127,124,146,122,27,104,110,110,104,104,168,110,174,156,154,146,149,151,31,247,43,51,5,138,134,139,134,135,26,104,167,111,173,173,167,167,174,173,111,167,105,30,14,248,148,248,20,247,61,21,123,124,133,129,128,31,251,44,227,5,140,144,140,144,144,26,144,138,144,138,144,30,247,42,227,5,128,151,154,132,156,27,174,168,168,174,175,110,167,104,104,110,111,103,134,140,134,140,134,31,251,42,52,5,149,127,124,146,122,27,104,110,110,104,104,168,110,174,156,154,146,149,151,31,247,43,51,5,138,134,139,134,135,26,104,167,111,173,173,167,167,174,173,111,167,105,30,247,150,4,151,148,129,127,128,130,129,127,127,130,149,150,151,148,149,151,31,251,148,251,84,21,127,130,148,151,151,148,148,151,151,148,130,127,127,130,130,127,31,247,148,251,42,21,127,130,149,150,151,148,149,151,151,148,129,127,128,130,129,127,31,14,248,148,248,20,247,61,21,123,124,133,129,128,31,251,44,227,5,140,144,140,144,144,26,144,138,144,138,144,30,247,42,227,5,128,151,154,132,156,27,174,168,168,174,175,110,167,104,104,110,111,103,134,140,134,140,134,31,251,42,52,5,149,127,124,146,122,27,104,110,110,104,104,168,110,174,156,154,146,149,151,31,247,43,51,5,138,134,139,134,135,26,104,167,111,173,173,167,167,174,173,111,167,105,30,14,248,148,248,20,247,61,21,123,124,133,129,128,31,251,44,227,5,140,144,140,144,144,26,144,138,144,138,144,30,247,42,227,5,128,151,154,132,156,27,174,168,168,174,175,110,167,104,104,110,111,103,134,140,134,140,134,31,251,42,52,5,149,127,124,146,122,27,104,110,110,104,104,168,110,174,156,154,146,149,151,31,247,43,51,5,138,134,139,134,135,26,104,167,111,173,173,167,167,174,173,111,167,105,30,14,248,148,247,20,247,20,21,247,73,247,20,251,73,247,20,5,251,148,7,247,105,247,148,21,251,148,182,247,148,96,7,14,248,148,247,20,248,20,21,182,251,148,96,247,148,6,214,251,20,21,247,73,251,20,139,247,148,251,73,251,20,5,14]);
    await loadFontFromList(buffer, fontFamily: family);
  }
}