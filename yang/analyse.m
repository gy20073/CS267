function [has, otime, loss]=analyse(batch, L, ngpu)
    fname=['batch' num2str(batch) '_L' num2str(L) '_GPU' num2str(ngpu) ...
        '.testloss'];
    fileId = fopen(fname);
    if fileId == -1
        has = false;
        otime = [];
        loss = [];
        return
    else
        has = true;
        C=textscan(fileId, '%s %{HH:mm:ss.SSSSSS}D %d %s     Test net output #1: loss = %f %[^\n]');
        time = C{2};
        otime = zeros(numel(time), 1);
        for i = 2 : numel(time)
            otime(i) = seconds(time(i) - time(1));
        end
        loss = C{5};
    end
end
