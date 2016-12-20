#!/bin/bash
killall -9 pd
pasuspender -- pd -open Aubio/AubioMaster.pd &
pd -noaudio MasterPofVj.pd
