function L = t1(varargin)
    Nx = varargin{1};
    Lx = varargin{2};

    Dimm = 1;

    if nargin > 2
        Ny = varargin{3};
        Ly = varargin{4};
        Dimm = 2;
    else
        Ny = 1;
        Ly = 0;
    end

    if nargin > 4
        Nz = varargin{5};
        Lz = varargin{6};
        Dimm = 3;
    else
        Nz = 1;
        Lz = 0;
    end

    hx = Lx / Nx;
    hy = Ly / Ny;
    hz = Lz / Nz;

    if (Dimm == 1)
        Dxx = (1 / hx^2) * spdiags([ones(Nx,1), -2*ones(Nx,1), ones(Nx,1)], [-1, 0, 1], Nx, Nx);
        D = Dxx;
    end

    if (Dimm == 2)
        Dxx = (1 / (hx ^ 2)) * spdiags([-2 * ones(Nx * Ny, 1), ones(Nx * Ny, 1), ones(Nx * Ny, 1)], [-Nx, 0, Nx], Nx * Ny, Nx * Ny);
        Dyy = (1 / (hy ^ 2)) * spdiags([-2 * ones(Nx * Ny, 1), ones(Nx * Ny, 1), ones(Nx * Ny, 1)], [-1, 0, 1], Nx * Ny, Nx * Ny);
        D = Dxx + Dyy;
    end

    if (Dimm == 3)
        Dxx = (1 / (hx ^ 2)) * spdiags([-2 * ones(Nx * Ny * Nz, 1), ones(Nx * Ny * Nz, 1), ones(Nx * Ny * Nz, 1)], [-Ny * Nz, 0, Ny * Nz], Nx * Ny * Nz, Nx * Ny * Nz)
        Dyy = (1 / (hy ^ 2)) * spdiags([-2 * ones(Nx * Ny * Nz, 1), ones(Nx * Ny * Nz, 1), ones(Nx * Ny * Nz, 1)], [-Nz, 0, Nz], Nx * Ny * Nz, Nx * Ny * Nz)
        Dzz = (1 / (hz ^ 2)) * spdiags([-2 * ones(Nx * Ny * Nz, 1), ones(Nx * Ny * Nz, 1), ones(Nx * Ny * Nz, 1)], [-1, 0, 1], Nx * Ny * Nz, Nx * Ny * Nz)
        D = Dxx + Dyy + Dzz;
    end

    L = D;

end
