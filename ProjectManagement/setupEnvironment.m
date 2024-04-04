function setupEnvironment(setupFlag)
  arguments
    setupFlag (1,1) logical = true;
  end

  SYSTEM_LOCATION_OF_LIBSTDC_PLUS_PLUS = "/usr/lib/x86_64-linux-gnu/";
  LD_LIBRARY_PATH = "LD_LIBRARY_PATH";

  stringAddition = SYSTEM_LOCATION_OF_LIBSTDC_PLUS_PLUS + ":";
  if setupFlag
    newValue =  stringAddition + getenv(LD_LIBRARY_PATH);
    setenv(LD_LIBRARY_PATH, stringAddition + newValue);
  else
    oldValue = getenv(LD_LIBRARY_PATH);
    newValue = replace(oldValue,stringAddition, "");
    setenv(LD_LIBRARY_PATH,newValue);
  end
end