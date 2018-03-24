
def add_commas(instr):
    out = [instr[0]]
    for i in range(1, len(instr)):
        if (len(instr) - i) % 3 == 0:
            out.append(',')
        out.append(instr[i])
    return ''.join(out)


def ncomma(instr):
    rng = reversed(range(1, len(instr) + (len(instr) - 1)//3 + 1))
    out = [',' if j%4 == 0 else instr[-(j - j//4)] for j in rng]
    return ''.join(out)

