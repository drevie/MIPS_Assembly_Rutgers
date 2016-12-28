## Daniel Revie
## 2/8/2016

.text 

main:

lw $t0 $s4($s1)      # A[i]
lw $t1 $s4($s2)      # A[j]

add $t2, $t1, $t0    # (A[j] + A[i])

mul $t2, $t1, $t2    # (A[j] + A[i]) * A[j]

sw $t2, $s5[$s3]     # B[k] = (A[j] + A[i]) * A[j]


li $v0 10
syscall 