function [density] = dol_dens(n,c,w,Pd,Pa,T,r)

density = (n*(1-c))/(pi*(w^2)*Pd*Pa*T*r);

end