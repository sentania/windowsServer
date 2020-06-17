    $cert = get-item A:\*.cer
    $cert | import-certificate -certstorelocation cert:\LocalMachine\Root