//
//  Copyright 2025 Antmicro
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#include "Vsim.h"
#include <verilated.h>

#if VM_TRACE
#include <cstring>
#include <string>
#include <verilated_vcd_c.h>
#endif

int main(int argc, char **argv, char **env) {
#ifdef RENODE_DEBUG_VERILATOR
  // Disable buffering of stdout to print logs
  // even when Verilator is terminated on timeout
  setbuf(stdout, NULL);
#endif
  VerilatedContext *contextp = new VerilatedContext;
  contextp->commandArgs(argc, argv);
  Vsim *top = new Vsim{contextp};

#if VM_TRACE
  Verilated::traceEverOn(true);
  VerilatedVcdC *tfp = new VerilatedVcdC;
  top->trace(tfp, 99);
  std::string out_file = "sim.vcd";
  for (int i = 1; i < argc; ++i) {
    std::string arg = argv[i];
    if (arg.rfind("+vcd=", 0) == 0) {
      out_file = arg.substr(strlen("+vcd="));
    }
  }
  tfp->open(out_file.c_str());
#endif

  while (!contextp->gotFinish()) {
    top->eval();
#if VM_TRACE
    tfp->dump(contextp->time());
#endif
    if (!top->eventsPending())
      break;
    contextp->time(top->nextTimeSlot());
  }

#if VM_TRACE
  tfp->close();
#endif
  delete top;
  delete contextp;
  return 0;
}
