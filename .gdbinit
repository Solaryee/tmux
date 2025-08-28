set print demangle on
set print asm-demangle on
set print pretty on
set environment HISTSIZE 10000000
set history filename ~/.gdb_history
set history save on
set history size 10000000
set history expansion on

python
import sys
sys.path.insert(0, '/usr/share/gcc/python')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end

define cc
  # 检查参数并设置便利变量
  if $argc == 0
    set $n = 1  # 默认值
  else
    set $n = $arg0
  end

  # 使用 Python 执行带错误检测的循环
  python
try:
    n = int(gdb.parse_and_eval("$n"))
    if n < 1 or n > 1000:
        raise ValueError("Invalid count")

    for i in range(n):
        try:
            gdb.execute('c', from_tty=False)
            print(f"执行次数: {i+1}/{n}")
        except gdb.error as e:
            if "The program is not being run" in str(e):
                print(f"程序已停止，无法继续执行剩余 {n-i-1} 次")
                break
            raise
except Exception as e:
    print(f"错误: {e}\n用法: cc [次数] (1-1000)")
end
