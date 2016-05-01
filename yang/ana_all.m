% analyze all, configurations
time_cutoff= 15;
plotmethod = @semilogy; %plotmethod = @plot;

Ls = [1 2 3]; %Ls = 1;
batches = [8 32 64 128 256]; %batches = 64;
gpus = [1 2 4]; gpus = 4;

% plotting
figure

legends = {};

for L = Ls
    for batch = batches
        for ngpu = gpus
            [has, time, loss] = analyse(batch, L, ngpu);
            if has
                ind = time < time_cutoff;
                time = time(ind);
                loss = loss(ind);
                
                plotmethod(time(:), loss(:));
                hold on
                legends{end+1} =['batch=' num2str(batch) ...
                                 ' L=' num2str(L) ...
                                 ' GPU=' num2str(ngpu)];
            end
        end
    end
end

xlabel('time');
ylabel('test loss');
legend(legends);
hold off
            